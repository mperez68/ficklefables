extends VBoxContainer

func _ready() -> void:
	$MasterSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	$MusicSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	$SFXSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Sfx"))
