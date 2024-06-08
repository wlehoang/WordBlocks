extends Node2D


func _ready():
	randomize()
	$AnimatedSprite.play("symbols")
	$AnimatedSprite.frame = randi() % 6
	$AnimatedSprite.stop()
	rotate(randi() % 360)
