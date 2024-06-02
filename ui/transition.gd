extends CanvasLayer

onready var animation_player := $AnimationPlayer

func _ready() -> void:
	animation_player.play("Fade Out")
	yield(animation_player, "animation_finished")
	
func fade_in():
	animation_player.play("Fade In")
	yield(animation_player, "animation_finished")

func fade_out():
	animation_player.play("Fade Out")
	yield(animation_player, "animation_finished")

func _on_AnimationPlayer_animation_finished(anim_name):
	print("stop")


func _on_AnimationPlayer_animation_started(anim_name):
	print("start")
