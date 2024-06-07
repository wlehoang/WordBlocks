extends Node2D

const Blocks = preload("res://entities/blocks/blocks.tscn")
export (int) var tile_size = 64
export (String) var scene_name
onready var player_name = "princess"

signal scene_changed(new_scene)

func _ready():
	add_to_group("map")
	$Player.player_name = player_name
	$Player/AnimatedSprite.play(player_name + "_idle_right")

func handle_block_spawn(column):
	var block = Blocks.instance()
	block.position = (Vector2((column + 1.5) * tile_size, tile_size + tile_size/2))
	block.select_block_type()
	add_child(block)

func _on_BlockSpawnTimer_timeout():
	randomize()
	handle_block_spawn(randi() % 14)

func _on_BlockFallTimer_timeout():
	get_tree().call_group("block", "handle_block_fall")

func _on_Player_trapped():
	emit_signal("scene_changed", "defeat")
