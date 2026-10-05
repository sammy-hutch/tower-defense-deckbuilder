extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D

var current_tiles: Array = []
var direction: Vector2
var speed: float = 20.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("mobs")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# update movement
	_update_velocity()
	move_and_slide()
	
	# update rotation
	sprite_2d.rotation = direction.angle() - (0.5 * PI)


func _update_velocity():
	direction = Vector2.ZERO
	for tile in current_tiles:
		direction += tile.flow_vector

	if current_tiles.size() > 0:
		direction /= current_tiles.size()
		direction = direction.normalized()
	
	velocity = direction * speed
	if get_slide_collision_count() > 0:
		var col = get_slide_collision(0)
		velocity = velocity.slide(col.get_normal())
		velocity = velocity.normalized() * speed

func _on_area_2d_area_entered(area: Area2D) -> void:
	var tile = area.get_parent()
	if tile.is_in_group("tiles"):
		#print("area entered: %s" % tile.name)
		current_tiles.append(tile)

func _on_area_2d_area_exited(area: Area2D) -> void:
	var tile = area.get_parent()
	if tile.is_in_group("tiles"):
		#print("area exited: %s" % tile.name)
		current_tiles.erase(tile)
