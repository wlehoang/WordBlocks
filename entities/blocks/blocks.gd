extends KinematicBody2D

func _ready():
	get_parent().get_node("%BlockFallTimer").connect("timeout", self, "onBlockFallTimer_timeout")

func onBlockFallTimer_timeout():
	var posDelta = Vector2.ZERO
	posDelta.y += get_parent().cell_size;
	var collision = move_and_collide(posDelta)
