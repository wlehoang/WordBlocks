extends AudioStreamPlayer

var sound_effects = {
	"drop block": "res://entities/player/assets/drop block.wav",
	"pick up block": "res://entities/player/assets/pick up block.wav",
	"power up": "res://entities/player/assets/powerUp.wav"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_sound(sfx):
	self.stream = load(sound_effects[sfx])
	self.play()
