extends Node2D

func _ready():
	randomize()
	$AnimatedSprite.frame = randi() % 44
	rotate(randi() % 360)
	add_to_group("eye_decoration")

func select_random_anim():
	randomize()
	var rnum = randi() % 2
	match rnum:
		0:
			$AnimatedSprite.play("blink")
		1:
			$AnimatedSprite.play("blink_cat")

