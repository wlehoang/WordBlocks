extends Node2D

func _ready():
	randomize()
	$AnimatedSprite.frame = randi() % 44
