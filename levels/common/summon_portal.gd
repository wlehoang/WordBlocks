extends Node2D

func _ready():
	$AnimatedSprite.play("spawn")

func _on_AnimatedSprite_animation_finished():
	queue_free()
