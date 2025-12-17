extends Node2D
class_name LobbySelect

var stage_list: Array[Dictionary] = [
	{	"music_name": "Body Talk",
		"stage_path": "res://scenes/music/music_scene/body_talk.tscn",
		"image_path": "res://resources/music/M2U/artworks-XQlk1klbagsZ74zz-nyIdaQ-t500x500.png"}
	#end of stages
]

# Called when the node enters the scene tree for the first time.
var button_generated: StageButton = null
var score_save_data: ScoreSaveData = null
var high_score: float = 0.0
func _ready() -> void:
	score_save_data = ScoreSaveData.new().load_data()
	for i in stage_list:
		if not score_save_data.score_dict.get(i.music_name):
			high_score = 0
		else:
			high_score = score_save_data.score_dict[i.music_name]
		button_generated = StageButtonGenerator.generate(i.music_name, i.stage_path, i.image_path, high_score)
		$LobbySelectBackground/StageContainer/StageVContainer.add_child(button_generated)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_lobby_main_request_move_to_lobby_select_to_lobby_select() -> void:
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(self, "position", Vector2(0,0), 0.5)
	pass # Replace with function body.

'''
func _on_button_pressed() -> void:
	StageLoad.path = "res://scenes/music/music_scene/body_talk.tscn"
	StageLoad.score = 0
	StageLoad.music_name = "Body Talk"
	get_tree().change_scene_to_file("res://scenes/game_started/game_ui.tscn")
	pass # Replace with function body.
'''
