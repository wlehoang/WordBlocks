extends Node

const PauseScreen = preload("res://ui/menus/pause_screen.tscn")
onready var current_scene = $MainMenuScreen 

func _ready():
	current_scene.connect("scene_changed", self, "handle_scene_changed")

func handle_scene_changed(current_scene_name: String):
	var next_scene
	match current_scene_name:
		"main": next_scene = load("res://levels/level_1/level_1.tscn").instance()
		"pause": next_scene = load("res://ui/menus/main_menu_screen.tscn").instance()
		"defeat": next_scene = load("res://ui/menus/main_menu_screen.tscn").instance()
		_: return
	add_child(next_scene)
	next_scene.connect("scene_changed", self, "handle_scene_changed")
	current_scene.queue_free()
	current_scene = next_scene
	
func _process(delta):
	if Input.is_action_pressed("pause"):
		var pause_menu = PauseScreen.instance()
		add_child(pause_menu)
		
