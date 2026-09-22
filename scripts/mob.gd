extends Node2D

var current_tiles: Array = []
var direction: Vector2
var speed: float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_update_direction()
	position += direction * speed * delta
	
	# TODO: make mobs move, possibly not registering that it enters area when it is entering the scene


func _update_direction():
	direction = Vector2.ZERO
	for tile in current_tiles:
		direction += tile.flow_vector

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("tiles"):
		current_tiles.append(area)

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("tiles"):
		current_tiles.erase(area)
