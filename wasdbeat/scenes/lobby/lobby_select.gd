extends Node2D
class_name LobbySelect

var stage_list: Dictionary = {
	"Body Talk" :{	"music_name": "Body Talk",
					"stage_path": "res://scenes/music/music_scene/body_talk.tscn",
					"icon_path": "res://resources/music/M2U/bodytalk_icon.png",
					"album_path": "res://resources/music/M2U/bodytalk_album.png"},
	"Body Talky" :{	"music_name": "Body Talky",
					"stage_path": "res://scenes/music/music_scene/body_talk.tscn",
					"icon_path": "res://resources/music/M2U/bodytalk_icon.png",
					"album_path": "res://resources/music/M2U/bodytalk_album.png"}
	#end of stages
}

# Called when the node enters the scene tree for the first time.
var button_generated: StageButton = null
var score_save_data: ScoreSaveData = null
var high_score: float = 0.0
func _ready() -> void:
	score_save_data = ScoreSaveData.new().load_data()
	for i in stage_list.keys():
		if not score_save_data.score_dict.get(stage_list[i]["music_name"]):
			high_score = 0
		else:
			high_score = score_save_data.score_dict[stage_list[i]["music_name"]]
		button_generated = StageButtonGenerator.generate(stage_list[i]["music_name"], stage_list[i]["stage_path"], stage_list[i]["icon_path"], high_score)
		$LobbySelectBackground/StageContainer/StageVContainer.add_child(button_generated)
		button_generated.change_album.connect(Callable(self, "change_album"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_lobby_main_request_move_to_lobby_select_to_lobby_select() -> void:
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(self, "position", Vector2(0,0), 0.5)
	pass # Replace with function body.

func change_album(stage_name: String) -> void:
	$MusicAlbum.texture = load(stage_list[stage_name]["album_path"])
	$MusicName.text = stage_list[stage_name]["music_name"]
	if not score_save_data.score_dict.get(stage_list[stage_name]["music_name"]):
		high_score = 0
	else:
		high_score = score_save_data.score_dict[stage_list[stage_name]["music_name"]]
	$BestScore.text = "%d" % int(high_score)
	pass
