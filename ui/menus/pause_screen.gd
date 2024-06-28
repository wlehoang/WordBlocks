extends CanvasLayer

export (String) var scene_name
signal scene_changed(new_scene)
var paused_scene

func _ready() -> void:
	$"%ContinueButton".grab_focus()
	get_tree().paused = true

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = false
		queue_free()

func _on_ContinueButton_pressed():
	get_tree().paused = false
	queue_free()

func _on_RestartButton_pressed():
	get_tree().paused = false
	emit_signal("scene_changed", paused_scene)
	queue_free()
	
func _on_MainMenuButton_pressed():
	get_tree().paused = false
	emit_signal("scene_changed", "main")
	queue_free()

func _on_OptionsButton_pressed():
	$"%OptionsMenu".show()

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_ContinueButton_mouse_entered():
	$"%ContinueButton".grab_focus()

func _on_RestartButton_mouse_entered():
	$"%RestartButton".grab_focus()

func _on_MainMenuButton_mouse_entered():
	$"%MainMenuButton".grab_focus()

func _on_OptionsButton_mouse_entered():
	$"%OptionsButton".grab_focus()

func _on_QuitButton_mouse_entered():
	$"%QuitButton".grab_focus()

func _on_HelpButton_pressed():
	$"%HelpScreen".show()

func _on_HelpButton_mouse_entered():
	$"%HelpButton".grab_focus()
