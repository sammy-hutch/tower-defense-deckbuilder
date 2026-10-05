extends Node2D

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var cooldown: Timer = $Cooldown

const arrow_scene = preload("res://scenes/arrow.tscn")

@export var cooldown_time: float = 5.0

var ready_to_attack: bool = true
var mobs_in_range: Array = []
var active_target: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	cooldown.wait_time = cooldown_time
	cooldown.timeout.connect(_on_cooldown_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ready_to_attack:
		if not mobs_in_range.is_empty():
			active_target = mobs_in_range[0]
			_shoot(active_target)
			

func _shoot(active_target: CharacterBody2D):
	var target_location = active_target.position
	var new_arrow = arrow_scene.instantiate()
	new_arrow.target_location = target_location
	new_arrow.position = global_position
	get_parent().add_child(new_arrow)
	
	ready_to_attack = false
	cooldown.start()
	

###### Signals ######

func _on_area_2d_area_entered(area: Area2D) -> void:
	var mob = area.get_parent()
	if mob.is_in_group("mobs") and mob is CharacterBody2D:
		print("TOWER area entered: %s" % mob.name)
		mobs_in_range.append(mob)

func _on_area_2d_area_exited(area: Area2D) -> void:
	var mob = area.get_parent()
	if mob.is_in_group("mobs") and mob is CharacterBody2D:
		print("TOWER area exited: %s" % mob.name)
		mobs_in_range.erase(mob)

func _on_cooldown_timeout() -> void:
	ready_to_attack = true
