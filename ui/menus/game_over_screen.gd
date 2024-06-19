extends CanvasLayer

export (String) var scene_name
signal scene_changed(new_scene)
var current_level

func _ready() -> void:
	$"%RestartButton".grab_focus()
	$"%Score".text = str(ScoreTracker.current_score)
	get_tree().paused = true

func _on_RestartButton_pressed():
	get_tree().paused = false
	emit_signal("scene_changed", current_level)

func _on_MainMenuButton_pressed():
	get_tree().paused = false
	emit_signal("scene_changed", "main")

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_RestartButton_mouse_entered():
	$"%RestartButton".grab_focus()

func _on_MainMenuButton_mouse_entered():
	$"%MainMenuButton".grab_focus()

func _on_QuitButton_mouse_entered():
	$"%QuitButton".grab_focus()
