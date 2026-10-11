extends Control

# Menu Scrolls nodes
@onready var palace_button: TextureButton = $VBoxContainer/MainView/ShopSelector/PalaceButton
@onready var palace_scroll_clip: Control = $PalaceScrollClip
@onready var palace_scroll_graphic: TextureRect = $PalaceScrollClip/PalaceScroll
@onready var market_button: TextureButton = $VBoxContainer/MainView/ShopSelector/MarketButton
@onready var market_scroll_clip: Control = $MarketScrollClip
@onready var market_scroll_graphic: TextureRect = $MarketScrollClip/MarketScroll
@onready var garrison_button: TextureButton = $VBoxContainer/MainView/ShopSelector/GarrisonButton
@onready var garrison_scroll_clip: Control = $GarrisonScrollClip
@onready var garrison_scroll_graphic: TextureRect = $GarrisonScrollClip/GarrisonScroll

# general scroll vars
var scroll_rolled_width := 0
var scroll_full_width := 110
var scroll_height := 80
var scroll_unroll_time := 0.5
var scroll_open: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# set config objects based on child nodes
	var palace_cfg = {
		"button": palace_button,
		"clip": palace_scroll_clip,
		"graphic": palace_scroll_graphic,
		"full_width": scroll_full_width,
		"rolled_width": scroll_rolled_width,
		"unroll_time": scroll_unroll_time,
		"open": scroll_open
	}
	var market_cfg = {
		"button": market_button,
		"clip": market_scroll_clip,
		"graphic": market_scroll_graphic,
		"full_width": scroll_full_width,
		"rolled_width": scroll_rolled_width,
		"unroll_time": scroll_unroll_time,
		"open": scroll_open
	}
	var garrison_cfg = {
		"button": garrison_button,
		"clip": garrison_scroll_clip,
		"graphic": garrison_scroll_graphic,
		"full_width": scroll_full_width,
		"rolled_width": scroll_rolled_width,
		"unroll_time": scroll_unroll_time,
		"open": scroll_open
	}

	for cfg in [palace_cfg, market_cfg, garrison_cfg]:
		cfg.button.pressed.connect(_on_scroll_button_pressed.bind(cfg))


func _on_scroll_button_pressed(cfg: Dictionary) -> void:
	# set config imports
	var button = cfg["button"]
	var clip = cfg["clip"]
	var full_w = cfg["full_width"]
	var rolled_w = cfg["rolled_width"]
	var time = cfg["unroll_time"]
	var open: bool = cfg["open"]
	
	# set temp utility vars
	var target_w = 0
	var handle_dest_x = 0

	# return if in motion
	if button.disabled:
		return
	
	button.disabled = true
	
	# set directional vars (for rolling in or out)
	if open:
		target_w = rolled_w
		handle_dest_x = button.position.x - full_w
	else:
		target_w = full_w
		handle_dest_x = button.position.x + full_w
	
	# create and run tween
	var parchment_tween := get_tree().create_tween()
	parchment_tween.tween_property(clip, "size:x", target_w, time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	var handle_tween := get_tree().create_tween()
	handle_tween.tween_property(button, "position:x", handle_dest_x, time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	handle_tween.finished.connect(func() -> void:
		print("open: %s" % open)
		print("handle tween finished")
		button.disabled = false
		var new_open_val = false
		if open == false:
			new_open_val = true
		cfg["open"] = new_open_val
		print("open: %s" % open)
	)
