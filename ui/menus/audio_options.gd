extends Control

onready var audio_name_label = $"%AudioNameLabel"
onready var audio_slider = $"%AudioSlider"
onready var audio_number_label = $"%AudioNumberLabel"

export(String, "Master", "Music", "Sfx") var bus_name
var bus_index: int = 0

func _ready():
	audio_slider.connect("value_changed", self, "on_value_changed")
	get_bus_name_by_index()
	set_slider_value()
	set_name_label_text()
	set_number_label_text()
	
func set_name_label_text():
	audio_name_label.text = bus_name + " Volume"
	
func set_number_label_text():
	audio_number_label.text = str(audio_slider.value * 100) + "%"
	
func get_bus_name_by_index():
	bus_index = AudioServer.get_bus_index(bus_name)

func set_slider_value():
	audio_slider.value = db2linear(AudioServer.get_bus_volume_db(bus_index))
	set_number_label_text()

func on_value_changed(value: float):
	AudioServer.set_bus_volume_db(bus_index, linear2db(value))
	set_number_label_text()
