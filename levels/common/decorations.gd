extends Node2D
const Eyes = preload("res://levels/common/eye.tscn")
const Blood = preload("res://levels/common/blood_splatter.tscn")
const Symbols = preload("res://levels/common/magic_symbols.tscn")
export var eye_range = Vector2(8, 10)
export var blood_range = Vector2(3, 6)
export var symbol_range = Vector2(4, 6)
var positions = []

var tile_size = Globals.tile_size

func _ready():
	positions = []
	set_random_decorations(eye_range, "eye_decoration")
	set_random_decorations(blood_range, "blood_decoration")
	set_random_decorations(symbol_range, "symbol_decoration")
		
func set_random_decorations(nrange: Vector2, deco: String):
	randomize()
	var num = rand_range(nrange.x, nrange.y)
	var min_x = 2 * tile_size
	var max_x = 14 * tile_size
	var min_y = 2.5 * tile_size
	var max_y = 11 * tile_size
	for _n in range(num):
		var x = 0
		var y = 0
		var overlapping = true
		while(overlapping):
			x = rand_range(min_x, max_x)
			y = rand_range(min_y, max_y)
			overlapping = false
			for pos in positions:
				var x_diff = abs(x - pos.x)
				var y_diff = abs(y - pos.y)
				if x_diff < tile_size*1.5 and y_diff < tile_size*1.5:
					overlapping = true
					break
		match deco:
			"eye_decoration":
				var new_deco = Eyes.instance()
				var scale_value = rand_range(0.75, 1.25)
				new_deco.scale = Vector2(scale_value, scale_value)
				new_deco.position = Vector2(x, y)
				new_deco.select_random_anim()
				add_child(new_deco)
			"blood_decoration":
				var new_deco = Blood.instance()
				var scale_value = rand_range(0.5, 1)
				new_deco.scale = Vector2(scale_value, scale_value)
				new_deco.position = Vector2(x, max_y + tile_size * 1.3)
				add_child(new_deco)
			"symbol_decoration":
				var new_deco = Symbols.instance()
				var scale_value = rand_range(0.25, 0.75)
				new_deco.scale = Vector2(scale_value, scale_value)
				new_deco.position = Vector2(x, y)
				add_child(new_deco)
		positions.append(Vector2(x, y))
		
func start_stunned_timer():
	$StunTimer.start(15)
	get_tree().call_group("eye_decoration", "start_stunned_state")

func _on_StunTimer_timeout():
	get_tree().call_group("eye_decoration", "stop_stunned_state")
