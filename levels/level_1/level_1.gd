extends Node2D

const Blocks = preload("res://entities/blocks/blocks.tscn")

func _ready():
	set_process_input(true)
	randomize()
	spawn(randi() % 20)
	
func _process(delta):
	randomize()
	spawn(randi() % 20)

func spawn(column):
	var node = Blocks.instance()
	var current_animation : String = node.get_node("AnimatedSprite").animation
	var sprite_texture : Texture = node.get_node("AnimatedSprite").frames.get_frame(current_animation, 0)
	var block_size = sprite_texture.get_size()
	var spawn_x = (column + 1) * block_size.x
	node.position = (Vector2(spawn_x, block_size.y / 2))
	add_child(node)
