extends Node2D

var score_data: ScoreSaveData = null

func _ready() -> void:
	$ColorRect/NoteScores.text = ("	Perfect\t: %d
									Great\t\t: %d
									Good\t\t: %d
									Bad\t\t\t: %d
									Miss\t\t: %d" % StageLoad.score_count)
	$ColorRect/Title.text = StageLoad.music_name
	var rank: String = ""
	if (StageLoad.score > 999999):
		rank = "M"
	elif (StageLoad.score >= 950000):
		rank = "S"
	elif (StageLoad.score >= 900000):
		rank = "A"
	elif (StageLoad.score >= 800000):
		rank = "B"
	elif (StageLoad.score >= 700000):
		rank = "C"
	else:
		rank = "F"
	$ColorRect/Rank.text = rank
	$ColorRect/Score.text = "Score : %d" % StageLoad.score
	
	score_data = ScoreSaveData.new().load_data()
	if score_data.score_dict.get(StageLoad.music_name):
		score_data.score_dict[StageLoad.music_name] = max(StageLoad.score, score_data.score_dict[StageLoad.music_name])
	else:
		score_data.score_dict[StageLoad.music_name] = StageLoad.score
	#print(score_data.score_dict)
	score_data.save_data()

func _on_next_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/lobby/lobby_ui.tscn")
	pass # Replace with function body.
