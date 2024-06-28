extends Popup

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton or event.is_action_pressed("ui_cancel"):
		hide()
