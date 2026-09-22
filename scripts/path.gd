extends Node2D

@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"

const path_cell_scene = preload("res://scenes/path_cell.tscn")

var path_cells: Array = []
var path_tiles: Array = []
var flow_map: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_build_path()
	_find_shortest_routes()


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

func _find_shortest_routes():
	var end_tiles = tile_map_layer.get_used_cells_by_id(-1,Vector2i(3,0),-1)
	var paths = []
	
	for end_tile in end_tiles:
		var discovered_new_tiles = true
		var path = [{"tile":end_tile, "steps": 0, "prev_tile": end_tile}]
		var searched_tiles = [end_tile]
		var active_tiles = path
		
		while discovered_new_tiles:
			discovered_new_tiles = false
			var next_active_tiles = []
			for tile in active_tiles:
				var current_step = tile["steps"] + 1
				var coords = tile["tile"]
				var possible_neighbours = [
					Vector2i(coords.x, coords.y - 1),		# n
					Vector2i(coords.x + 1, coords.y - 1),	# ne
					Vector2i(coords.x + 1, coords.y),		# e
					Vector2i(coords.x + 1, coords.y + 1),	# se
					Vector2i(coords.x, coords.y + 1),		# s
					Vector2i(coords.x - 1, coords.y + 1),	# sw
					Vector2i(coords.x - 1, coords.y),		# w
					Vector2i(coords.x - 1, coords.y - 1)	# nw
					]
				
				for neighbour in possible_neighbours:
					if path_tiles.has(neighbour) and not searched_tiles.has(neighbour):
						var tile_info = {
							"tile": neighbour, 
							"steps": current_step, 
							"prev_tile": coords
							}
						path.append(tile_info)
						next_active_tiles.append(tile_info)
						searched_tiles.append(neighbour)
						discovered_new_tiles = true
				
			active_tiles = next_active_tiles
		
		paths.append({"target": end_tile, "tiles": path})
	
	flow_map.clear()
	for path in paths:
		for tile in path["tiles"]:
			_update_flow_map(tile)
	
	for cell_info in flow_map:
		_update_path_cells(cell_info)
			
		
func _update_flow_map(new_tile):
	for i in range(flow_map.size()):
		if flow_map[i]["tile"] == new_tile.tile:
			if new_tile.steps < flow_map[i]["steps"]:
				flow_map[i] = new_tile
			return
	flow_map.append(new_tile)

func _update_path_cells(cell_info):
	for cell in path_cells:
		if cell.tile_pos == cell_info.tile:
			var from = cell_info.tile
			var to = cell_info.prev_tile
			var vector = Vector2(to.x - from.x, to.y - from.y)
			var angle = vector.angle() + (0.5 * PI)
			cell.flow_direction = angle
