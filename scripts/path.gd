extends Node2D

@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"
@onready var t: Timer = $"../Timer"

const path_cell_scene = preload("res://scenes/path_cell.tscn")
const mob_scene = preload("res://scenes/mob.tscn")

var cell_lookup := {}
var flow_map := {}

var path_cells: Array = []
var path_tiles: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_build_path()
	_find_shortest_routes()
	
	t.wait_time = 2.0
	t.autostart = true
	t.timeout.connect(_on_timer_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _build_path():
	var tile_set = tile_map_layer.tile_set
	var tile_size: Vector2i = tile_set.tile_size
	path_tiles.clear()
	
	for atlas_x_coord in [1,2,3]: # 0: wall. 1: path. 2: start. 3: end.
		var tile_array = tile_map_layer.get_used_cells_by_id(-1,Vector2i(atlas_x_coord,0),-1)
		path_tiles.append_array(tile_array)
	
	for cell in path_tiles:
		var coords = cell
		
		var new_cell = path_cell_scene.instantiate()
		new_cell.load_vars(
			tile_map_layer, 
			coords, tile_size,
			self
			)
		
		add_child(new_cell)
		path_cells.append(new_cell)
	
	for cell in path_cells:
		cell.setup()
		cell_lookup[cell.tile_pos] = cell


func _find_shortest_routes():
	var end_tiles = tile_map_layer.get_used_cells_by_id(-1, Vector2i(3,0), -1)
	var paths = []
	
	for end_tile in end_tiles:
		var queue = []
		var visited = {}
		var path = []
		
		queue.append({"tile": end_tile, "steps": 0, "distance": 0, "prev_tile": end_tile})
		visited[end_tile] = 0
		
		while queue.size() > 0:
			var current = queue.pop_front()
			path.append(current)
			
			var coords = current["tile"]
			var next_step = current["steps"] + 1
			var neighbours: Array[Vector2i] = [
				Vector2i(coords.x, coords.y - 1),
				Vector2i(coords.x + 1, coords.y - 1),
				Vector2i(coords.x + 1, coords.y),
				Vector2i(coords.x + 1, coords.y + 1),
				Vector2i(coords.x, coords.y + 1),
				Vector2i(coords.x - 1, coords.y + 1),
				Vector2i(coords.x - 1, coords.y),
				Vector2i(coords.x - 1, coords.y - 1)
			]
			
			for n in neighbours:
				if path_tiles.has(n):
					var dist = snapped(n.length(), 0.01) + current["distance"]
					if not visited.has(n) or dist < visited[n]:
						visited[n] = dist
						queue.append({
							"tile": n,
							"steps": next_step,
							"distance": dist,
							"prev_tile": coords
						})
		
		paths.append({"target": end_tile, "tiles": path})

	# Build flow map
	flow_map.clear()
	for path in paths:
		for tile_info in path["tiles"]:
			_update_flow_map(tile_info)


	# Apply flow directions to cells
	for cell_info in flow_map.values():
		_update_path_cells(cell_info)


func _spawn_mob():
	var entry_points = tile_map_layer.get_used_cells_by_id(-1, Vector2i(2,0), -1)
	var entry_point: Vector2i
	
	if len(entry_points) > 0:
		entry_point = entry_points.pick_random()
	
	var world_pos = tile_map_layer.map_to_local(entry_point)
	var tile_size = tile_map_layer.tile_set.tile_size.x
	var x_fuzz = randi_range(-tile_size, tile_size)
	var y_fuzz = randi_range(-tile_size, tile_size)
	world_pos += Vector2(x_fuzz, y_fuzz)
	
	var new_mob = mob_scene.instantiate()
	new_mob.position = world_pos
	
	add_child(new_mob)
	

###### HELPER FUNCTIONS ######

func _update_flow_map(new_tile):
	var tile = new_tile["tile"]
	
	if flow_map.has(tile):
		if new_tile["distance"] < flow_map[tile]["distance"]:
			flow_map[tile] = new_tile
	else:
		flow_map[tile] = new_tile


func _update_path_cells(cell_info):
	var cell = cell_lookup.get(cell_info["tile"], null)
	if cell == null:
		return
	
	var from = cell_info["tile"]
	var to = cell_info["prev_tile"]
	var vector = Vector2(to.x - from.x, to.y - from.y)
	var angle = vector.angle() + (0.5*PI)
	cell.flow_direction = angle
	cell.flow_vector = vector


###### Signals ######

func _on_timer_timeout() -> void:
	_spawn_mob()
