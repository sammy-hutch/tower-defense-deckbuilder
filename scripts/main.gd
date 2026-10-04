extends Node2D

@onready var map: Node2D = $Map
@onready var camera_2d: Camera2D = $Camera2D
@onready var tilemap_layer = $Map/TileMapLayer
@onready var map_window: Control = $CanvasLayer/UI/VBoxContainer/MainView/MapWindow

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#await get_tree().process_frame
	
	var viewport_width = ProjectSettings.get_setting("display/window/size/viewport_width")
	var viewport_height = ProjectSettings.get_setting("display/window/size/viewport_height")

	var tile_map: TileMapLayer = tilemap_layer
	var map_rect = tile_map.get_used_rect()
	if map_rect.size == Vector2i.ZERO:
		push_error("TileMapLayer has no tiles!")
		return
	var map_pixel_size = map_rect.size * tile_map.tile_set.tile_size
	var map_window_size = map_window.size
	
	var zoom_x = map_window_size.x / map_pixel_size.x
	var zoom_y = map_window_size.y / map_pixel_size.y
	var zoom = min(zoom_x, zoom_y)
	zoom = max(zoom, 0.001)
	
	print("map_pixel_size: ", map_pixel_size)
	print("map_window_size: ", map_window_size)
	print("zoom_x: ", zoom_x, " zoom_y: ", zoom_y, " zoom: ", zoom)
	
	camera_2d.zoom = Vector2(zoom, zoom)
	
	var map_center = map_rect.position * tile_map.tile_set.tile_size + map_pixel_size / 2
	camera_2d.global_position = map_center



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
