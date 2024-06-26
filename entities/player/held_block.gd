extends AnimatedSprite

enum Types {Empty, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Random, Bonus, Pause, Bomb, Locked, Sideways, Mystery}

func _ready():
	hide()
	
func handle_block_animation(block_type: int):
	if block_type == -1:
		hide()
	else:
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
			Types.Locked:
				animation_name = "block_locked"
			Types.Sideways:
				randomize()
				var left_or_right = randi() % 2
				if left_or_right == 1:
					animation_name = "block_left"
				else:
					animation_name = "block_right"
			Types.Mystery:
				animation_name = "block_mystery"
		show()
		play(animation_name)
