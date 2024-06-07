extends Control

onready var label = $"%Label"
onready var button = $"%Button"

export var action_name : String = "move_left"

func _ready():
	add_to_group("hotkey_button")
	set_process_unhandled_key_input(false)
	set_action_name()
	set_key_text()
	
func set_action_name():
	label.text = action_name.replace("_", " ").capitalize()

func set_key_text():
	var action_events = InputMap.get_action_list(action_name)
	var action_event = action_events[0]
	var action_keycode = OS.get_scancode_string(action_event.scancode)
	button.text = "%s" % action_keycode

func _unhandled_key_input(event):
	rebind_action_key(event)
	button.emit_signal("toggled", false)
	button.pressed = false
	
func rebind_action_key(event):
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, event)
	set_process_unhandled_key_input(false)
	set_key_text()
	set_action_name()

func _on_Button_toggled(button_pressed):
	if button_pressed:
		button.text = "Press any key"
		set_process_unhandled_key_input(button_pressed)
		for hbutton in get_tree().get_nodes_in_group("hotkey_button"):
			if hbutton.action_name != self.action_name:
				hbutton.button.toggle_mode = false
				hbutton.set_process_unhandled_key_input(false)
	else:
		for hbutton in get_tree().get_nodes_in_group("hotkey_button"):
			if hbutton.action_name != self.action_name:
				hbutton.button.toggle_mode = true
				hbutton.set_process_unhandled_key_input(false)
		set_key_text()

func _on_Button_mouse_entered():
	button.grab_focus()
