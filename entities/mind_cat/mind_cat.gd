extends KinematicBody2D

var move_dir = Globals.tile_size

func _ready():
	add_to_group("cat")
	$AnimatedSprite.play("idle")

func handle_movement():
	var pos_delta = Vector2.ZERO
	pos_delta.x += move_dir;
	if not test_move(transform, pos_delta):
		var _collision = move_and_collide(pos_delta)
	else:
		move_dir = -move_dir
		$AnimatedSprite.play("summon")
	
func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.play("idle")
