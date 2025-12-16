extends ColorRect

var option_data: Options = null

signal option_done()

func _ready() -> void:
	if (option_data == null):
		option_data = Options.new().load_data()
	
	$MasterSlider.value = option_data.master_volume
	$MusicSlider.value = option_data.music_volume
	$SoundEffectSlider.value = option_data.effect_volume
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),linear_to_db(float($MasterSlider.value))/100)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"),linear_to_db(float($MusicSlider.value))/100)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),linear_to_db(float($SoundEffectSlider.value))/100)
	$InputOffsetBox.offset = option_data.input_offset
	$InputOffsetBox.change_offset_fun()
	$MusicOffsetBox.offset = option_data.music_offset
	$MusicOffsetBox.change_offset_fun()
	pass
	


func _on_done_pressed() -> void:
	option_data.master_volume = $MasterSlider.value
	option_data.music_volume = $MusicSlider.value
	option_data.effect_volume = $SoundEffectSlider.value
	option_data.input_offset = $InputOffsetBox.offset
	option_data.music_offset = $MusicOffsetBox.offset
	option_data.save_data()
	option_done.emit()
	pass # Replace with function body.
