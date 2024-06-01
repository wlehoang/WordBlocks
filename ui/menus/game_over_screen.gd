extends CanvasLayer

export (String) var scene_name
signal scene_changed(scene_name)

func _ready() -> void:
	get_tree().paused = true

func _on_RestartButton_pressed():
	get_tree().paused = false
	emit_signal("scene_changed", scene_name)

func _on_QuitButton_pressed():
	get_tree().quit()
