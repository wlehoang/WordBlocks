extends KinematicBody2D

const Blocks = preload("res://entities/blocks/blocks.tscn")
onready var facing = $FacingRayCast
onready var selectionarea = $SelectionArea

var tile_size
var inventory = null
var gravity = 1000

func _ready():
	tile_size = get_parent().tile_size
	facing.cast_to = Vector2(tile_size, 0)
	add_to_group("player")

func _physics_process(delta):
	move_and_slide(Vector2(0, gravity), Vector2.UP)
	if int(position.x) % (tile_size/2) != 0 or int(position.y) % (tile_size/2) != 0:
		position = Globals.snap_to_grid(position, tile_size)

func _unhandled_input(event):
	if event.is_action_pressed("select_down"):
		handle_selection_area("down")
	elif event.is_action_pressed("select_right"):
		handle_selection_area("right")
	elif event.is_action_pressed("select_left"):
		handle_selection_area("left")
	elif event.is_action_pressed("move_right"):
		handle_move("right")
	elif event.is_action_pressed("move_left"):
		handle_move("left")
	elif event.is_action_pressed("pickup"):
		if inventory == null:
			var all_selected = get_tree().get_nodes_in_group("selected")
			if all_selected.size() > 0:
				inventory = all_selected[0].block_type
				all_selected[0].queue_free()
				print("block picked up: " + str(inventory))
	elif event.is_action_pressed("drop"):
		if not facing.is_colliding() and inventory:
			print("block dropped: " + str(inventory))
			var dropped_block = Blocks.instance()
			var spawn_position = facing.global_transform * facing.cast_to
			dropped_block.position = Globals.snap_to_grid(spawn_position, tile_size)
			dropped_block.select_block_type(inventory)
			get_parent().add_child(dropped_block)
			inventory = null

func handle_selection_area(area: String):
	if area == "down":
		selectionarea.global_position.x = global_position.x - tile_size
		selectionarea.global_position.y = global_position.y + tile_size
		facing.cast_to = Vector2(0, tile_size)
	elif area == "right":
		selectionarea.global_position.x = global_position.x
		selectionarea.global_position.y = global_position.y
		facing.cast_to = Vector2(tile_size, 0)
	elif area == "left":
		selectionarea.global_position.x = global_position.x - 2*tile_size
		selectionarea.global_position.y = global_position.y
		facing.cast_to = Vector2(-tile_size, 0)
		
func handle_move(direction: String):
	var pos_delta = Vector2.ZERO
	if direction == "right":
		pos_delta.x += tile_size
	elif direction == "left":
		pos_delta.x -= tile_size
	var collision = move_and_collide(pos_delta)
	if collision:
		var collided_object = collision.get_collider()
		if collided_object.is_in_group("block"):
			handle_jump()
			collision = move_and_collide(pos_delta)
	if direction == "right":
		handle_selection_area("right")
	elif direction == "left":
		handle_selection_area("left")
	
func handle_jump():
	var pos_delta = Vector2.ZERO
	var scale_height = 1.01
	pos_delta.y -= (tile_size * scale_height)
	if is_on_floor():
		var collision = move_and_collide(pos_delta)

func _on_SelectionArea_body_entered(body):
	if body.is_in_group("block"):
		body.add_to_group("selected")

func _on_SelectionArea_body_exited(body):
	if body.is_in_group("block"):
		body.remove_from_group("selected")
