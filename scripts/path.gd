extends Node2D

@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"

const path_cell_scene = preload("res://scenes/path_cell.tscn")

var path_cells: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_build_path()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _build_path():
	var tile_set = tile_map_layer.tile_set
	var tile_size: Vector2i = tile_set.tile_size
	
	var path_tiles = []
	for atlas_x_coord in [1,2,3]: # 1: regular path. 2: start. 3: end.
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
