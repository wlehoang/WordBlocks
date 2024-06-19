extends CanvasLayer

export (String) var scene_name
const Blocks = preload("res://entities/blocks/blocks.tscn")

onready var title_array = [23, 15, 18, 4, 31, 2, 12, 15, 3, 11, 19]
onready var block_size = 64
onready var selected_character = "princess"

var screen_size
signal scene_changed(new_scene)

func _ready():
	screen_size = get_viewport().size
	var x_offset = (screen_size.x - (title_array.size() * block_size))/2
	var y_offset = screen_size.y/4
	$PrincessArea/VBoxContainer/Name1.grab_focus()
	for i in range(title_array.size()):
		var block = Blocks.instance()
		block.select_block_type(title_array[i])
		block.position = Vector2(i*block_size + x_offset + block_size/2, y_offset)
		add_child(block)
	handle_character_select()
	$Eye.get_node("AnimatedSprite").play("blink_cat")
	$Eye.rotation = 0
	$"%Value1".text = str(ScoreTracker.high_score["level1"])
	$"%Value2".text = str(ScoreTracker.high_score["level2"]) 
	$"%Value3".text = str(ScoreTracker.high_score["level3"]) 
	
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
	if event.is_action_pressed("select_left") or event.is_action_pressed("ui_left") or event.is_action_pressed("ui_focus_prev"):
		match selected_character:
			"princess":
				selected_character = "wizard"
			"knight":
				selected_character = "princess"
			"wizard":
				selected_character = "knight"
		handle_character_select()
	elif event.is_action_pressed("select_right") or event.is_action_pressed("ui_right") or event.is_action_pressed("ui_focus_next"):
		match selected_character:
			"princess":
				selected_character = "knight"
			"knight":
				selected_character = "wizard"
			"wizard":
				selected_character = "princess"
		handle_character_select()
			
func _on_StartButton_pressed():
	var level
	match selected_character:
		"princess":
			level = "level1"
		"knight":
			level = "level2"
		"wizard":
			level = "level3"
	emit_signal("scene_changed", level)

func _on_OptionsButton_pressed():
	$"%OptionsMenu".show()

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_StartButton_mouse_entered():
	$"%StartButton".grab_focus()

func _on_OptionsButton_mouse_entered():
	$"%OptionsButton".grab_focus()

func _on_ExitButton_mouse_entered():
	$"%ExitButton".grab_focus()

func _on_PrincessArea_mouse_entered():
	selected_character = "princess"
	handle_character_select()
	$PrincessArea/VBoxContainer/Name1.grab_focus()

func _on_KnightArea_mouse_entered():
	selected_character = "knight"
	handle_character_select()
	$KnightArea/VBoxContainer/Name2.grab_focus()

func _on_WizardArea_mouse_entered():
	selected_character = "wizard"
	handle_character_select()
	$WizardArea/VBoxContainer/Name3.grab_focus()

func _on_PrincessArea_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		emit_signal("scene_changed", "level1")

func _on_KnightArea_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		emit_signal("scene_changed", "level2")

func _on_WizardArea_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		emit_signal("scene_changed", "level3")

func _on_Name1_mouse_entered():
	selected_character = "princess"
	handle_character_select()
	$PrincessArea/VBoxContainer/Name1.grab_focus()
	
func _on_Name2_mouse_entered():
	selected_character = "knight"
	handle_character_select()
	$KnightArea/VBoxContainer/Name2.grab_focus()

func _on_Name3_mouse_entered():
	selected_character = "wizard"
	handle_character_select()
	$WizardArea/VBoxContainer/Name3.grab_focus()

func _on_Name1_pressed():
	emit_signal("scene_changed", "level1")

func _on_Name2_pressed():
	emit_signal("scene_changed", "level2")

func _on_Name3_pressed():
	emit_signal("scene_changed", "level3")
