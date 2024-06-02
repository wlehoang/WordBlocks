extends Node2D

const Blocks = preload("res://entities/blocks/blocks.tscn")

var cell_size = 64

func _ready():
	set_process_input(true)
	randomize()
	spawn(randi() % 20)
	
func _process(delta):
	pass
	#randomize()
	#spawn(randi() % 20)

func spawn(column):
	var node = Blocks.instance()
	var current_animation : String = node.get_node("AnimatedSprite").animation
	var sprite_texture : Texture = node.get_node("AnimatedSprite").frames.get_frame(current_animation, 0)
	var block_size = Vector2(cell_size, cell_size)
	var texture_size = sprite_texture.get_size()
	var scale_factor = block_size * 0.99 / texture_size
	node.scale = scale_factor
	var spawn_x = (column + 1.5) * block_size.x
	node.position = (Vector2(spawn_x, block_size.y / 2))
	add_child(node)


func _on_BlockSpawnTimer_timeout():
	randomize()
	spawn(randi() % 20)
