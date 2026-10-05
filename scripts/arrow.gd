extends Node2D

var start_location: Vector2
var target_location: Vector2
var direction: Vector2
var speed: float = 200.0
var collision_object: CharacterBody2D

var max_distance: float = 0.0
var max_distance_fluff: float = 25.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_location = position
	direction = (target_location - position).normalized()
	max_distance = (target_location - position).length() + max_distance_fluff
	rotation = direction.angle()
	print("ARROW position: %s" % position)
	print("ARROW target location: %s" % target_location)
	print("ARROW direction: %s" % direction)
	print("ARROW max distance: %s" % max_distance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if collision_object:
		print("arrow strikes true!")
		collision_object.queue_free()
		queue_free()
	elif (position - start_location).length() > max_distance:
		print("arrow missed!")
		queue_free()
	else:
		position += direction * speed * delta


func _on_area_2d_area_entered(area: Area2D) -> void:
	var potential_target = area.get_parent()
	if potential_target.is_in_group("mobs"):
		print("ARROW area entered: %s" % potential_target.name)
		collision_object = potential_target
