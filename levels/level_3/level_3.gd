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
	block.position = (Vector2((column + 1.5) * tile_size, -tile_size / 2))
	block.select_block_type()
	add_child(block)

func handle_next_level():
	emit_signal("scene_changed", scene_name)

func _on_BlockSpawnTimer_timeout():
	randomize()
	handle_block_spawn(randi() % 14)

func _on_BlockFallTimer_timeout():
	get_tree().call_group("block", "handle_block_fall")
