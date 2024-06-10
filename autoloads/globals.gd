extends Node

export (int) var tile_size = 64
var mouse_enabled = true

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

func snap_to_grid(pos: Vector2):
	pos.x = round(pos.x / (tile_size/2)) * (tile_size/2)
	pos.y = round(pos.y / (tile_size/2)) * (tile_size/2)
	return pos
