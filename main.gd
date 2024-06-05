extends Node

const PauseScreen = preload("res://ui/menus/pause_screen.tscn")
const TransitionScreen = preload("res://ui/transition.tscn")
onready var current_scene = $MainMenuScreen
onready var transition_screen
var paused = false
var current_level = "level1"

func _ready():
	current_scene.connect("scene_changed", self, "handle_scene_changed")
	transition_screen = TransitionScreen.instance()
	add_child(transition_screen)

func handle_scene_changed(next_scene_name: String):
	var next_scene
	transition_screen.fade_in()
	match next_scene_name:
		"main": 
			next_scene = load("res://ui/menus/main_menu_screen.tscn").instance()
		"defeat": 
			next_scene = load("res://ui/menus/game_over_screen.tscn").instance()
			next_scene.current_level = current_level
		"level1": 
			next_scene = load("res://levels/level_1/level_1.tscn").instance()
			current_level = "level1"
		"level2": 
			next_scene = load("res://levels/level_2/level_2.tscn").instance()
			current_level = "level2"
		"level3": 
			next_scene = load("res://levels/level_3/level_3.tscn").instance()
			current_level = "level3"
		_: 
			return
	add_child(next_scene)
	next_scene.connect("scene_changed", self, "handle_scene_changed")
	current_scene.queue_free()
	current_scene = next_scene
	transition_screen.fade_out()
	
func _input(event):
	if event.is_action_pressed("ui_cancel") and current_scene.name != "MainMenuScreen":
		if not paused:
			var pause_menu = PauseScreen.instance()
			pause_menu.paused_scene = current_scene.scene_name
			pause_menu.connect("scene_changed", self, "handle_scene_changed")
			pause_menu.connect("tree_exited", self, "handle_pause")
			paused = true
			add_child(pause_menu)
		
func handle_pause():
	paused = false
