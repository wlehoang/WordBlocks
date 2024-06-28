extends Popup

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		hide()

func _on_Button_pressed():
	hide()
