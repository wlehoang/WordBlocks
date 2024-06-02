extends KinematicBody2D
var screen_size
var speed = 128
var cell_size = 16

func _ready():
	screen_size = get_viewport_rect().size
	position.x = clamp(screen_size.x/2, 25, screen_size.x - 25)
	position.y = clamp(screen_size.y-55, 25, screen_size.y - 25)
	add_to_group("player")
	
func position_snapped(pos:Vector2):
	return (pos / cell_size).floor() * cell_size

# warning-ignore:unused_argument
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
	if Input.is_action_pressed("move_up"):
		velocity.y -= speed
	if Input.is_action_pressed("move_down"):
		velocity.y += speed
		
	var collision = move_and_collide(velocity * delta)

