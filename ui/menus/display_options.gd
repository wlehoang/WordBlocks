extends Control

onready var option = $"%WindowOptionsButton"

const WINDOW_MODE_ARRAY = [
	"Window Mode",
	"Full-Screen"
]

func _ready():
	add_window_mode_items()
	option.connect("item_selected", self, "on_window_mode_selected")
	
func add_window_mode_items():
	for window_mode in WINDOW_MODE_ARRAY:
		option.add_item(window_mode)
		
func on_window_mode_selected(index: int):
	match index:
		0:
			OS.window_fullscreen = false
			OS.window_borderless = false
		1:
			OS.window_fullscreen = true
			OS.window_borderless = false
