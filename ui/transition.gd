extends CanvasLayer

onready var animation_player := $"%TransitionAnimations"

func _ready() -> void:
	fade_out()
	
func fade_in():
	animation_player.play("Fade In")
	yield(animation_player, "animation_finished")

func fade_out():
	animation_player.play_backwards("Fade In")
	yield(animation_player, "animation_finished")
