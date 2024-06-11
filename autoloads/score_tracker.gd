extends Node

onready var high_score = {
	"level1": 0,
	"level2": 0,
	"level3": 0
}
onready var current_score = 0
onready var score_multiplier: float = 1

#1 point - A, E, I, O, U, L, N, S, T, R.
#2 points - D, G.
#3 points - B, C, M, P.
#4 points - F, H, V, W, Y.
#5 points - K.
#8 points - J, X.
#10 points - Q, Z.

onready var score_values = {
	1: 1,
	2: 3,
	3: 3,
	4: 2,
	5: 1,
	6: 4,
	7: 2,
	8: 4,
	9: 1,
	10: 8,
	11: 5,
	12: 1,
	13: 3,
	14: 1,
	15: 1,
	16: 3,
	17: 10,
	18: 1,
	19: 1,
	20: 1,
	21: 1,
	22: 4,
	23: 4,
	24: 8,
	25: 4,
	26: 10
}
signal score_changed
signal multiplier_changed

func reset_score_tracker():
	score_multiplier = 1
	current_score = 0
		
func handle_score_change(letter: int):
	var value = score_values[letter]
	current_score += value * score_multiplier * 100
	emit_signal("score_changed")
	
func handle_multiplier_change(val: float):
	if val == 1:
		score_multiplier = 1
	else:
		score_multiplier *= val
	emit_signal("multiplier_changed")
	
func update_high_score(level: String):
	if current_score > high_score[level]:
		high_score[level] = current_score
