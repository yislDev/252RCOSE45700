extends Resource
class_name ScoreSaveData

const PATH := "res://save/score_save.tres"

@export var score_dict: Dictionary

func save_data() -> void:
	ResourceSaver.save(self,PATH)

func load_data() -> ScoreSaveData:
	if not ResourceLoader.exists(PATH):
		save_data()
	
	var res := ResourceLoader.load(PATH)
	return res as ScoreSaveData
