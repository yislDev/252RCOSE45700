extends Node
class_name StageButtonGenerator

const stage_button = "res://scenes/lobby/stage_button.tscn"

static func generate(music_name: String, stage_path: String, image_path: String, high_score: float) -> StageButton:
	var inst: StageButton = preload(stage_button).instantiate() as StageButton
	inst.set_stage_high_score(high_score)
	inst.set_stage_image(image_path)
	inst.set_stage_name(music_name)
	inst.set_stage_path(stage_path)
	return inst
