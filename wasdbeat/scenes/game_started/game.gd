extends Node2D
class_name Game

#노트 출현 시간
const TIME_NOTE_READY: float = 1.000
const TIME_NOTE_TOO_LATE: float = 0.150

#판정 시스템
const TIME_PERFECT: float = 0.050
const TIME_GREAT: float = 0.080
const TIME_GOOD: float = 0.110
const TIME_BAD: float = 0.150

enum NOTE_SCORE {
	PERFECT,
	GREAT,
	GOOD,
	BAD,
	FAIL
}

#패널 설정
const PANEL_NUM_COLUMNS: int = 4
const PANEL_NUM_ROWS: int = 4

signal request_generate_note(panel_index: int)
signal request_move_player(player_location: Vector2)
signal request_remove_note(panel_index)

var score: float = 0.0
var time_game_playing: float = 0.0
var note_queue: Array[Array] = []
var note_current: Array[Array] = []

var player_location: Vector2 = Vector2(0,0)
var player_index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time_game_playing = 0.0
	player_location = Vector2(0,0)
	player_index = 0
	
	#빈 배열 준비 (테스트용)
	for i in range(16):
		var new_empty_note_line: Array[float] = []
		new_empty_note_line = []
		note_queue.push_back(new_empty_note_line)
		var new_empty_note_line_cur: Array[float] = []
		new_empty_note_line_cur = []
		note_current.push_back(new_empty_note_line_cur)
	#
	
	#테스트 노트들
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
			note_current[i].push_back(note_queue[i].pop_front())
			request_generate_note.emit(i)
		pass
	pass

#입력 받았을 때
func _on_game_ui_request_move_player(dir: GameUI.DIR) -> void:
	print(note_current)
	
	#시간 저장해두기
	var time_at_input: float
	time_at_input = time_game_playing
	
	###플레이어 위치 구하기###
	match dir:
		GameUI.DIR.LEFT:
			player_location.y -= 1
			if (player_location.y <= -1):
				player_location.y = PANEL_NUM_COLUMNS-1
		GameUI.DIR.RIGHT:
			player_location.y += 1
			if (player_location.y >= PANEL_NUM_COLUMNS):
				player_location.y = 0
		GameUI.DIR.UP:
			player_location.x -= 1
			if (player_location.x <= -1):
				player_location.x = PANEL_NUM_ROWS-1
		GameUI.DIR.DOWN:
			player_location.x += 1
			if (player_location.x >= PANEL_NUM_ROWS):
				player_location.x = 0
				
	###노트 처리###
	player_index = player_location.x * 4 + player_location.y
	
	#기한 지난 노트 삭제
	print(note_current[player_index])
	while ((not note_current[player_index].is_empty()) \
			and (time_at_input - note_current[player_index][0] >= TIME_NOTE_TOO_LATE)):
		note_current[player_index].pop_front()
	
	#기한이 지나지 않은 노트 처리
	var cur_note_timing: float
	var note_score: NOTE_SCORE
	print(note_current[player_index])
	if (not note_current[player_index].is_empty()):
		cur_note_timing = time_at_input - note_current[player_index].pop_front()
		print(cur_note_timing)
		if (abs(cur_note_timing) <= TIME_PERFECT):
			note_score = NOTE_SCORE.PERFECT
		elif (abs(cur_note_timing) <= TIME_GREAT):
			note_score = NOTE_SCORE.GREAT
		elif (abs(cur_note_timing) <= TIME_GOOD):
			note_score = NOTE_SCORE.GOOD
		elif (abs(cur_note_timing) <= TIME_BAD):
			note_score = NOTE_SCORE.BAD
		else:
			note_score = NOTE_SCORE.FAIL
				
		match note_score:
			NOTE_SCORE.PERFECT:
				score += 1000
			NOTE_SCORE.GREAT:
				score += 100
			NOTE_SCORE.GOOD:
				score+= 10
			NOTE_SCORE.BAD:
				score+= 1
				
		request_remove_note.emit(player_index)
				
	###플레이어 움직이기###
	request_move_player.emit(player_location)
	pass # Replace with function body.
