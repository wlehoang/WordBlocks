extends Control

export (String) var scene_name

func _on_ExitButton1_pressed():
	hide()

func _on_ExitButton2_pressed():
	hide()

func _on_ExitButton3_pressed():
	hide()

func _on_ToggleMouseButton_toggled(button_pressed):
	Globals.mouse_enabled = !Globals.mouse_enabled
