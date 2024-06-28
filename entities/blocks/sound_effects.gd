extends AudioStreamPlayer

var sound_effects = {
	"explosion": "res://entities/blocks/assets/explosion.wav",
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_sound(sfx):
	print(sfx)
	self.stream = load(sound_effects[sfx])
	self.play()
