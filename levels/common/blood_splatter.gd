extends Node2D

func _ready():
	randomize()
	$AnimatedSprite.play("blood_splatter")
	$AnimatedSprite.frame = randi() % 6
	$AnimatedSprite.stop()

