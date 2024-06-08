extends KinematicBody2D

enum Types {Empty, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Random, Bonus, Pause, Bomb, Locked, Mystery}
export (String) var block_type = Types.Empty
var selected = false

func _ready():
	$Highlight.hide()
	add_to_group("block")
	
func handle_block_fall():
	var pos_delta = Vector2.ZERO
	pos_delta.y += Globals.tile_size;
	if not test_move(transform, pos_delta):
		var collision = move_and_collide(pos_delta)
	detect_word()

func handle_block_selection():
	if selected == false:
		$Highlight.show()
		selected = true
	else:
		$Highlight.hide()
		selected = false
		
func sample_letter():
	var letter_distribution = [1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 7, 7, 7, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9, 9, 10, 11, 12, 12, 12, 12, 13, 13, 14, 14, 14, 14, 14, 14, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 17, 18, 18, 18, 18, 18, 18, 19, 19, 19, 19, 20, 20, 20, 20, 20, 20, 21, 21, 21, 21, 22, 22, 23, 23, 24, 25, 25, 26]
	return letter_distribution[randi() % letter_distribution.size()]
		
func select_block_type(block_number: int = -1):
	if block_number == -1:
		var chance_of_special_tile = 0.15
		randomize()
		if randf() < chance_of_special_tile:
			block_number = 27 + randi() % 6
		else:
			block_number = sample_letter()
	block_type = block_number
	var animation_name = ""
	match block_type:
		Types.Empty:
			animation_name = "block_empty"
		Types.A:
			animation_name = "block_a"
		Types.B:
			animation_name = "block_b"
		Types.C:
			animation_name = "block_c"
		Types.D:
			animation_name = "block_d"
		Types.E:
			animation_name = "block_e"
		Types.F:
			animation_name = "block_f"
		Types.G:
			animation_name = "block_g"
		Types.H:
			animation_name = "block_h"
		Types.I:
			animation_name = "block_i"
		Types.J:
			animation_name = "block_j"
		Types.K:
			animation_name = "block_k"
		Types.L:
			animation_name = "block_l"
		Types.M:
			animation_name = "block_m"
		Types.N:
			animation_name = "block_n"
		Types.O:
			animation_name = "block_o"
		Types.P:
			animation_name = "block_p"
		Types.Q:
			animation_name = "block_q"
		Types.R:
			animation_name = "block_r"
		Types.S:
			animation_name = "block_s"
		Types.T:
			animation_name = "block_t"
		Types.U:
			animation_name = "block_u"
		Types.V: 
			animation_name = "block_v"
		Types.W:
			animation_name = "block_w"
		Types.X:
			animation_name = "block_x"
		Types.Y:
			animation_name = "block_y"
		Types.Z:
			animation_name = "block_z"
		Types.Random:
			animation_name = "block_random"
		Types.Bonus:
			animation_name = "block_bonus"
		Types.Pause:
			animation_name = "block_clock"
		Types.Bomb:
			animation_name = "block_bomb"
			$ExplosionTimer.start(10)
		Types.Locked:
			animation_name = "block_locked"
		Types.Mystery:
			animation_name = "block_mystery"
	$AnimatedSprite.play(animation_name)

func _on_SelectionArea_area_entered(area):
	handle_block_selection()

func _on_SelectionArea_area_exited(area):
	handle_block_selection()

func type_to_letter(type):
	match type:
		Types.A:
			return "a"
		Types.B:
			return "b"
		Types.C:
			return "c"
		Types.D:
			return "d"
		Types.E:
			return "e"
		Types.F:
			return "f"
		Types.G:
			return "g"
		Types.H:
			return "h"
		Types.I:
			return "i"
		Types.J:
			return "j"
		Types.K:
			return "k"
		Types.L:
			return "l"
		Types.M:
			return "m"
		Types.N:
			return "n"
		Types.O:
			return "o"
		Types.P:
			return "p"
		Types.Q:
			return "q"
		Types.R:
			return "r"
		Types.S:
			return "s"
		Types.T:
			return "t"
		Types.U:
			return "u"
		Types.V: 
			return "v"
		Types.W:
			return "w"
		Types.X:
			return "x"
		Types.Y:
			return "y"
		Types.Z:
			return "z"
	return " "

func detect_word():
	var left = get_node("Left")
	var up = get_node("Up")
	if (left.get_overlapping_bodies().size() > 0 && "block_type" in left.get_overlapping_bodies()[0]):
		return
	var letter_chain = get_word_chain()
	if letter_chain.length() >= 4:
		var letter_indexes = check_letter_chain(letter_chain)
		if letter_indexes.size() == 2:
			pop_letter_chain(letter_indexes)

func get_word_chain():
	var word_chain = ""
	var letter_reader = self
	while letter_reader != null:
		word_chain += type_to_letter(letter_reader.block_type)
		var right = letter_reader.get_node("Right")
		if (right.get_overlapping_bodies().size() > 0 && "block_type" in right.get_overlapping_bodies()[0]):
			letter_reader = right.get_overlapping_bodies()[0]
		else:
			letter_reader = null
	return word_chain

func check_letter_chain(letter_chain):
	for i in range(letter_chain.length() - 5):
		var substring = letter_chain.substr(i, 6)
		if (get_parent().get_parent().get_node("WordList").has_word(substring)):
			return [i, i+6]
	for i in range(letter_chain.length() - 4):
		var substring = letter_chain.substr(i, 5)
		if (get_parent().get_parent().get_node("WordList").has_word(substring)):
			return [i, i+5]
	for i in range(letter_chain.length() - 3):
		var substring = letter_chain.substr(i, 4)
		if (get_parent().get_parent().get_node("WordList").has_word(substring)):
			return [i, i+4]
	return []

func pop_letter_chain(letter_indexes):
	var letter_tracker = self
	var letter_index = 0
	while letter_tracker != null && letter_index < letter_indexes[1]:
		if letter_index >= letter_indexes[0] && letter_index < letter_indexes[1]:
			letter_tracker.queue_free()
		var right = letter_tracker.get_node("Right")
		var collisions = right.get_overlapping_bodies()
		if collisions.size() > 0:
			letter_tracker = collisions[0]
		else:
			letter_tracker = null
		letter_index += 1

func _on_ShowTimer_timeout():
	show()

func _on_ExplosionTimer_timeout():
	if block_type == Types.Bomb:
		var blast_zone = ["Up", "Down", "Left", "Right", "UpperRight", "LowerRight", "LowerLeft", "UpperLeft"]
		for zone in blast_zone:
			var area_node = get_node(zone)
			var bodies = area_node.get_overlapping_bodies()
			for body in bodies:
				if body.is_in_group("block"):
					body.queue_free()
		queue_free()
