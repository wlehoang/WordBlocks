extends KinematicBody2D

export (String) var block_type = "empty"

func _ready():
	get_parent().get_node("%BlockFallTimer").connect("timeout", self, "onBlockFallTimer_timeout")
	add_to_group("block")

func onBlockFallTimer_timeout():
	var posDelta = Vector2.ZERO
	posDelta.y += get_parent().tile_size;
	if not test_move(transform, posDelta):
		var collision = move_and_collide(posDelta)
