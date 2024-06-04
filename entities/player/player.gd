extends KinematicBody2D

const Blocks = preload("res://entities/blocks/blocks.tscn")
onready var facing = $FacingRayCast
onready var selectionarea = $SelectionArea
onready var direction = "right"

export (String) var player_name = "princess"
var tile_size
var inventory = -1
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
	if event.is_action_pressed("select_up"):
		handle_selection_area("up")
	elif event.is_action_pressed("select_down"):
		handle_selection_area("down")
	elif event.is_action_pressed("select_right"):
		handle_selection_area("right")
	elif event.is_action_pressed("select_left"):
		handle_selection_area("left")
	elif event.is_action_pressed("move_right"):
		handle_move("right")
	elif event.is_action_pressed("move_left"):
		handle_move("left")
	elif event.is_action_pressed("pickup_or_drop"):
		if inventory == -1:
			var all_selected = get_tree().get_nodes_in_group("selected")
			if all_selected.size() > 0:
				inventory = all_selected[0].block_type
				all_selected[0].queue_free()
				print("block picked up: " + str(inventory))
		else:
			if not facing.is_colliding():
				print("block dropped: " + str(inventory))
				var dropped_block = Blocks.instance()
				var spawn_position = facing.global_transform * facing.cast_to
				dropped_block.position = Globals.snap_to_grid(spawn_position, tile_size)
				dropped_block.select_block_type(inventory)
				get_parent().add_child(dropped_block)
				inventory = -1
			else:
				var collider = facing.get_collider()
				if collider.is_in_group("block"):
					var sel_block = collider.block_type
					print("block swapped: " + str(inventory) + " for " + str(sel_block))
					collider.select_block_type(inventory)
					inventory = sel_block

func handle_selection_area(area: String):
	if area == "up":
		selectionarea.global_position.x = global_position.x - tile_size
		selectionarea.global_position.y = global_position.y - tile_size
		facing.cast_to = Vector2(0, -tile_size)
	elif area == "down":
		selectionarea.global_position.x = global_position.x - tile_size
		selectionarea.global_position.y = global_position.y + tile_size
		facing.cast_to = Vector2(0, tile_size)
	elif area == "right":
		selectionarea.global_position.x = global_position.x
		selectionarea.global_position.y = global_position.y
		facing.cast_to = Vector2(tile_size, 0)
		direction = "right"
		$AnimatedSprite.play(player_name + "_idle_" + direction)
	elif area == "left":
		selectionarea.global_position.x = global_position.x - 2*tile_size
		selectionarea.global_position.y = global_position.y
		facing.cast_to = Vector2(-tile_size, 0)
		direction = "left"
		$AnimatedSprite.play(player_name + "_idle_" + direction)
		
func handle_move(direction: String):
	var pos_delta = Vector2.ZERO
	if direction == "right":
		pos_delta.x += tile_size
	elif direction == "left":
		pos_delta.x -= tile_size
	var collision = move_and_collide(pos_delta)
	if direction == "right":
		handle_selection_area("right")
	elif direction == "left":
		handle_selection_area("left")
	$AnimatedSprite.play(player_name + "_walk_" + direction)
	if collision:
		var collided_object = collision.get_collider()
		if collided_object.is_in_group("block"):
			handle_jump()
			collision = move_and_collide(pos_delta)
	
func handle_jump():
	var pos_delta = Vector2.ZERO
	var scale_height = 1.01
	pos_delta.y -= (tile_size * scale_height)
	if is_on_floor():
		var collision = move_and_collide(pos_delta)
		$AnimatedSprite.play(player_name + "_jump_" + direction)

func _on_SelectionArea_body_entered(body):
	if body.is_in_group("block"):
		body.add_to_group("selected")

func _on_SelectionArea_body_exited(body):
	if body.is_in_group("block"):
		body.remove_from_group("selected")

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.play(player_name + "_idle_" + direction)
