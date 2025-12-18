extends Node2D
class_name Game

#노트 출현 시간
const TIME_NOTE_READY: float = 1.000
const TIME_NOTE_TOO_LATE: float = 0.150
const TIME_PLAYER_READY: float = 3.000

#판정 시스템
const TIME_PERFECT: float = 0.050
const TIME_GREAT: float = 0.080
const TIME_GOOD: float = 0.110
const TIME_BAD: float = 0.140

enum NOTE_SCORE {
	PERFECT,
	GREAT,
	GOOD,
	BAD,
	MISS
}

#패널 설정
const PANEL_NUM_COLUMNS: int = 4
const PANEL_NUM_ROWS: int = 4

signal request_generate_note(panel_index: int)
signal request_move_player(player_location: Vector2)
signal request_remove_note(panel_index)
signal request_pause()

var score: float = 0.0
var note_count: int = 0
var score_of_perfect: float = 0.0
var score_count: Array[int] = [0,0,0,0,0]

var time_game_playing: float = 0.0
var note_queue: Array[Array] = []
var note_current: Array[Array] = []

var player_location: Vector2 = Vector2(0,0)
var player_index: int = 0

var music_bpm: float = 0.0
var music_music: AudioStream
var music_artists: String = ""
var music_note_list: Array[NoteInfo] = []
var music_end_of_song: float = 1000.0
var music_offset: float = 0.000

var second_per_beat: float = 1.0

var options: Options = null
var option_note_appearance_offset: float = 0.0
var option_input_offset: float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	options = Options.new().load_data()
	option_input_offset = float(options.input_offset) / 100
	option_note_appearance_offset = float(options.note_offset) / 100
	print("input offset %f" % option_input_offset)
	print("note offset %f" % option_note_appearance_offset)
	
	time_game_playing = -TIME_PLAYER_READY
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
	
	music_ready()
	
	pass
	
var target_scene_path: String #= "res://scenes/music/music_scene/body_talk.tscn"
func music_ready() -> void:
	
	target_scene_path = StageLoad.path
	
	var target_scene: MusicData = load(target_scene_path).instantiate() as MusicData
	music_bpm = target_scene.bpm
	music_music = target_scene.music
	music_artists = target_scene.artists
	music_note_list = target_scene.note_list
	music_end_of_song = target_scene.end_of_song
	music_offset = target_scene.offset
	
	second_per_beat = bpm_to_spb(music_bpm)
	
	note_count = music_note_list.size()
	
	for i in music_note_list:
		note_queue[i.panel].append(i.time * second_per_beat + music_offset + option_note_appearance_offset)
		#print(i.panel, i.time)
	
	var audio_manager: AudioManager = load("res://scenes/music/Audio/audio_manager.tscn").instantiate() as AudioManager
	audio_manager.set_bus("BGM")
	add_child(audio_manager)
	#print(music_music)
	get_tree().create_timer(TIME_PLAYER_READY, false).connect("timeout", Callable(audio_manager, "play_bgm").bind(music_music))
	#audio_manager.play_bgm(music_music)
	
	#테스트 노트들
	#note_queue[1].append(3.5)
	#note_queue[2].append(4.0)
	#note_queue[3].append(4.5)
	#note_queue[2].append(5.0)
	#
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_game_playing += delta
	$ColorRect/Score.text = ("%d" % score)
	$ColorRect/Time.text = ("Time : %f" % time_game_playing)
	$ColorRect/NoteScores.text = ("	Perfect\t: %d
									Great\t\t: %d
									Good\t\t: %d
									Bad\t\t\t: %d
									Miss\t\t: %d" % score_count)
	
	if (time_game_playing >= music_end_of_song):
		stage_end()
	
	#큐에서 노트 읽어와서 대기시키기
	for i in range(16):
		if (note_queue[i].is_empty()):
			pass
		elif (note_queue[i][0] - time_game_playing <= TIME_NOTE_READY):
			note_current[i].push_back(note_queue[i].pop_front())
			request_generate_note.emit(i)
		pass
	
	#늦은 노트 처리하기
	for i in range(16):
		if (not note_current[i].is_empty()):
			while((not note_current[i].is_empty()) \
			and (time_game_playing - note_current[i][0] + option_input_offset >= TIME_NOTE_TOO_LATE)):
				note_current[i].pop_front()
				score_count[4] += 1
				
	pass

#입력 받았을 때
func _on_game_ui_request_move_player(dir: GameUI.DIR) -> void:
	#print(note_current)
	
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
	
	'''
	#기한 지난 노트 삭제
	print(note_current[player_index])
	while ((not note_current[player_index].is_empty()) \
			and (time_at_input - note_current[player_index][0] >= TIME_NOTE_TOO_LATE)):
		note_current[player_index].pop_front()
	'''
	
	#기한이 지나지 않은 노트 처리
	var cur_note_timing: float
	var note_score: NOTE_SCORE
	#print(note_current[player_index])
	
	print(time_at_input / bpm_to_spb(106.667))
	if (not note_current[player_index].is_empty()):
		cur_note_timing = time_at_input + option_input_offset - note_current[player_index].pop_front()
		#print(cur_note_timing)
		if (abs(cur_note_timing) <= TIME_PERFECT):
			note_score = NOTE_SCORE.PERFECT
		elif (abs(cur_note_timing) <= TIME_GREAT):
			note_score = NOTE_SCORE.GREAT
		elif (abs(cur_note_timing) <= TIME_GOOD):
			note_score = NOTE_SCORE.GOOD
		elif (abs(cur_note_timing) <= TIME_BAD):
			note_score = NOTE_SCORE.BAD
		else:
			note_score = NOTE_SCORE.MISS
				
		match note_score:
			NOTE_SCORE.PERFECT:
				score_count[0] += 1
			NOTE_SCORE.GREAT:
				score_count[1] += 1
			NOTE_SCORE.GOOD:
				score_count[2] += 1
			NOTE_SCORE.BAD:
				score_count[3] += 1
			NOTE_SCORE.MISS:
				score_count[4] += 1
		request_remove_note.emit(player_index)
		
		_update_total_score()
				
	###플레이어 움직이기###
	request_move_player.emit(player_location)
	pass # Replace with function body.


#BPM을 Beat당 Second(SPB)로
func bpm_to_spb(bpm: float) -> float:
	return 60 / bpm
	

#스테이지 끝
func stage_end() -> void:
	StageLoad.score = score
	StageLoad.score_count = score_count
	get_tree().change_scene_to_file("res://scenes/stage_end/stage_end.tscn")
	pass


func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/lobby/lobby_ui.tscn")
	pass # Replace with function body.


func _on_game_pause_pressed() -> void:
	request_pause.emit()
	pass # Replace with function body.

# 새로운 점수 계산 함수 추가
func _update_total_score() -> void:
	if note_count == 0: return
	
	# 각 판정별 가중치 (Perfect를 100으로 잡고 정수로 계산)
	var current_weight: float = (score_count[0] * 100.0) + \
								(score_count[1] * 90.0) + \
								(score_count[2] * 75.0) + \
								(score_count[3] * 50.0)
	
	var max_weight: float = note_count * 100.0
	
	# 전체 가중치 비율을 1,000,000점에 곱함
	# 이 방식은 마지막 노트를 Perfect로 쳤을 때 정확히 1,000,000이 나옵니다.
	score = (current_weight / max_weight) * 1000000.0
