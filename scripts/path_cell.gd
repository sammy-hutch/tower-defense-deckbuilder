extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

var tile_size: Vector2i = Vector2i(32,32)
var tile_map_layer: TileMapLayer
var neighbours: Array = []
var path: Node2D
var tile_pos: Vector2i
var flow_direction = 0
var flow_vector: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func load_vars(tile_map_layer_ref, coords, tile_size_ref, path_ref):
	tile_pos = coords
	name = str(coords.x) + "_" + str(coords.y)
	tile_map_layer = tile_map_layer_ref
	position = tile_map_layer.map_to_local(coords)
	tile_size = tile_size_ref
	path = path_ref

func setup():
	_find_neighbours()
	_pathfind()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sprite_2d.rotation = flow_direction

func _find_neighbours():
	for cell in tile_map_layer.get_used_cells():
		var x_diff = cell.x - tile_pos.x
		var y_diff = cell.y - tile_pos.y
		
		if x_diff >= -1 and x_diff <= 1 \
		and y_diff >= -1 and y_diff <= 1 \
		and x_diff != 0 and y_diff != 0:
			neighbours.append(cell)

func _pathfind():
	var start_pos = tile_pos
	var destinations = tile_map_layer.get_used_cells_by_id(-1,Vector2i(3,0),-1)
	
	# TODO: pathfinding logic
