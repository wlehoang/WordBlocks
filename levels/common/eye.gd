extends Node2D

var eye_anim = "blink_cat"

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
			eye_anim = "blink"
		1:
			eye_anim = "blink_cat"
	$AnimatedSprite.play(eye_anim)
	$AnimatedSprite.frame = randi() % 44
			
func start_stunned_state():
	$AnimatedSprite.play("crazy")
	$AnimatedSprite.frame = randi() % 4
		
func stop_stunned_state():
	$AnimatedSprite.play(eye_anim)
	$AnimatedSprite.frame = randi() % 44

