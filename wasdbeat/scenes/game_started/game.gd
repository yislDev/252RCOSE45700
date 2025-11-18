extends Node2D
class_name Game

#노트 출현 시간
const TIME_NOTE_READY: float = 1.5
const TIME_NOTE_TOO_LATE: float = 0.15

#판정 범위
const TIME_PERFECT: float = 0.050
const TIME_GREAT: float = 0.075
const TIME_GOOD: float = 0.100
const TIME_BAD: float = 0.150

signal request_generate_note(panel_index: int)
signal request_move_player(dir: GameUI.DIR)

var score: float = 0.0
var time_game_playing: float = 0.0
var note_queue: Array[Array] = []

var player_location: Vector2 = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time_game_playing = 0.0
	player_location = Vector2(0,0)
	
	#빈 배열 준비 (테스트용)
	for i in range(16):
		var new_empty_note_line: Array[float] = []
		note_queue.push_back(new_empty_note_line)

	note_queue[1].append(3.5)
	note_queue[2].append(4.0)
	note_queue[3].append(4.5)
	note_queue[2].append(5.0)
	#
	
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_game_playing += delta
	$ColorRect/Score.text = ("Score : %f" % score)
	$ColorRect/Time.text = ("Time : %f" % time_game_playing)
	
	for i in range(16):
		if (note_queue[i].is_empty()):
			pass
		elif (note_queue[i][0] - time_game_playing <= TIME_NOTE_READY):
			note_queue[i].pop_front()
			request_generate_note.emit(i)
		pass
	pass


func _on_game_ui_request_move_player(dir: GameUI.DIR) -> void:
	request_move_player.emit(dir)
	match dir:
		GameUI.DIR.LEFT:
			pass
	pass # Replace with function body.
