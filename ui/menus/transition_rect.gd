extends ColorRect

onready var animation_player := $AnimationPlayer

func _ready() -> void:
	animation_player.play_backwards("Fade")
	
func handle_scene_transition():
	animation_player.play("Fade")
	yield(animation_player, "animation_finished")
	animation_player.play_backwards("Fade")
