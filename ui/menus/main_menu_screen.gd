extends CanvasLayer

export (String) var scene_name
signal scene_changed(scene_name)

func _ready():
	$PanelContainer/MarginContainer/Rows/CenterContainer/ButtonRows/PlayButton.grab_focus()

func _on_PlayButton_pressed():
	emit_signal("scene_changed", scene_name)

func _on_ExitButton_pressed():
	get_tree().quit()
