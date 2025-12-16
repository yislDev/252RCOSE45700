extends Resource
class_name Options

const PATH := "res://save/options.tres"

@export var master_volume = 0.0
@export var music_volume = 0.0
@export var effect_volume = 0.0
@export var input_offset = 0.0
@export var music_offset = 0.0

func save_data() -> void:
	ResourceSaver.save(self,PATH)

func load_data() -> Options:
	if not ResourceLoader.exists(PATH):
		save_data()
	
	var res := ResourceLoader.load(PATH)
	return res as Options
