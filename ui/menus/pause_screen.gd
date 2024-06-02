extends CanvasLayer

export (String) var scene_name
signal scene_changed(scene_name)

func _ready() -> void:
	$PanelContainer/MarginContainer/Rows/CenterContainer/ButtonRows/ContinueButton.grab_focus()
	get_tree().paused = true

func _on_ContinueButton_pressed():
	get_tree().paused = false
	queue_free()

func _on_RestartButton_pressed():
	get_tree().paused = false
	queue_free()
	emit_signal("scene_changed", scene_name)

func _on_QuitButton_pressed():
	get_tree().quit()
