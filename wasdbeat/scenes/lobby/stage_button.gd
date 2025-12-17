extends Control
class_name StageButton

var stage_name: String = ""
var stage_high_score: float = 0.0
var stage_path: String = ""

signal change_album(stage_name: String)

func set_stage_name(name: String) -> void:
	stage_name = name
	$StageName.text = name
	
func set_stage_image(path: String) -> void:
	$StageImage.texture = load(path)
	
func set_stage_high_score(score: float) -> void:
	stage_high_score = score
	
func set_stage_path(path: String) -> void:
	stage_path = path

func button_pressed() -> void:
	StageLoad.path = stage_path
	StageLoad.score = 0
	StageLoad.music_name = stage_name
	get_tree().change_scene_to_file("res://scenes/game_started/game_ui.tscn")

func _on_stage_start_mouse_entered() -> void:
	change_album.emit(stage_name)
	pass # Replace with function body.
