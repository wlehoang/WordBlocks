extends Node

func snap_to_grid(pos: Vector2, tile_size):
	pos.x = round(pos.x / (tile_size/2)) * (tile_size/2)
	pos.y = round(pos.y / (tile_size/2)) * (tile_size/2)
	return pos