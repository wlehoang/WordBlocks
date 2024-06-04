extends Node

const PauseScreen = preload("res://ui/menus/pause_screen.tscn")
const TransitionScreen = preload("res://ui/transition.tscn")
onready var current_scene = $MainMenuScreen
onready var transition_screen
var paused = false

func _ready():
	current_scene.connect("scene_changed", self, "handle_scene_changed")
	transition_screen = TransitionScreen.instance()
	add_child(transition_screen)

func handle_scene_changed(current_scene_name: String):
	var next_scene
	transition_screen.fade_in()
	match current_scene_name:
		"main": next_scene = load("res://levels/level_1/level_1.tscn").instance()
		"pause": next_scene = load("res://ui/menus/main_menu_screen.tscn").instance()
		"defeat": next_scene = load("res://ui/menus/main_menu_screen.tscn").instance()
		_: return
	add_child(next_scene)
	next_scene.connect("scene_changed", self, "handle_scene_changed")
	current_scene.queue_free()
	current_scene = next_scene
	transition_screen.fade_out()
	
func _input(event):
	if event.is_action_pressed("ui_cancel") and current_scene.name != "MainMenuScreen":
		if not paused:
			var pause_menu = PauseScreen.instance()
			pause_menu.connect("scene_changed", self, "handle_scene_changed")
			pause_menu.connect("tree_exited", self, "handle_pause")
			paused = true
			add_child(pause_menu)
		
func handle_pause():
	paused = false
