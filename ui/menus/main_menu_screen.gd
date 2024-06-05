extends CanvasLayer

export (String) var scene_name
const Blocks = preload("res://entities/blocks/blocks.tscn")
onready var title_array = [23, 15, 18, 4, 31, 2, 12, 15, 3, 11, 19]
onready var block_size = 64
onready var selected_character = "princess"
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
	handle_character_select()
	$Eye.get_node("AnimatedSprite").play("blink_cat")
	
func handle_character_select():
	match selected_character:
		"princess":
			$Eye.position.x = $PrincessArea.position.x
			$PrincessArea/FadeOut.hide()
			$KnightArea/FadeOut.show()
			$WizardArea/FadeOut.show()
		"knight":
			$Eye.position.x = $KnightArea.position.x
			$PrincessArea/FadeOut.show()
			$KnightArea/FadeOut.hide()
			$WizardArea/FadeOut.show()
		"wizard":
			$Eye.position.x = $WizardArea.position.x
			$PrincessArea/FadeOut.show()
			$KnightArea/FadeOut.show()
			$WizardArea/FadeOut.hide()

func _input(event):
	if event.is_action_pressed("select_right"):
		if selected_character == "princess":
			selected_character = "knight"
		elif selected_character == "knight":
			selected_character = "wizard"
		elif selected_character == "wizard":
			selected_character = "princess"
		handle_character_select()
	elif event.is_action_pressed("select_left"):
		if selected_character == "princess":
			selected_character = "wizard"
		elif selected_character == "knight":
			selected_character = "princess"
		elif selected_character == "wizard":
			selected_character = "knight"
		handle_character_select()
			
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

func _on_PrincessArea_mouse_entered():
	selected_character = "princess"
	handle_character_select()

func _on_KnightArea_mouse_entered():
	selected_character = "knight"
	handle_character_select()

func _on_WizardArea_mouse_entered():
	selected_character = "wizard"
	handle_character_select()
