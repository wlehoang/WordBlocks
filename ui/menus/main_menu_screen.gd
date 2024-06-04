extends CanvasLayer

export (String) var scene_name
const Blocks = preload("res://entities/blocks/blocks.tscn")
onready var title_array = [23, 15, 18, 4, 31, 2, 12, 15, 3, 11, 19]
onready var block_size = 64
var screen_size
	
signal scene_changed(scene_name)

func _ready():
	screen_size = get_viewport().size
	var x_offset = (screen_size.x - (title_array.size()*block_size))/2
	var y_offset = screen_size.y / 4
	$"%StartButton".grab_focus()
	for i in range(title_array.size()):
		var block = Blocks.instance()
		block.select_block_type(title_array[i])
		block.position = Vector2(i*block_size + x_offset + block_size/2, y_offset)
		add_child(block)
	
func _on_StartButton_pressed():
	emit_signal("scene_changed", scene_name)

func _on_SettingsButton_pressed():
	pass

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_StartButton_mouse_entered():
	$"%StartButton".grab_focus()

func _on_SettingsButton_mouse_entered():
	$"%SettingsButton".grab_focus()

func _on_ExitButton_mouse_entered():
	$"%ExitButton".grab_focus()
