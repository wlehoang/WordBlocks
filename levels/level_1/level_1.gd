extends Node2D

const Blocks = preload("res://entities/blocks/blocks.tscn")
export (String) var scene_name
export (int) var tile_size = 64

signal scene_changed(scene_name)

func _ready():
	add_to_group("map")
	
func _process(delta):
	pass

func handle_block_spawn(column):
	var block = Blocks.instance()
	var current_animation : String = block.get_node("AnimatedSprite").animation
	block.position = (Vector2((column + 1.5) * tile_size, tile_size / 2))
	add_child(block)

func handle_next_level():
	emit_signal("scene_changed", scene_name)

func _on_BlockSpawnTimer_timeout():
	randomize()
	handle_block_spawn(randi() % 14)
