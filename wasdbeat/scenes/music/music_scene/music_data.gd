extends Control
class_name MusicData

#바뀌지 않는 요소
@export var bpm: float
@export var music: AudioStream
@export var artists: String
@export var note_list: Array[NoteInfo]
@export var end_of_song: float
@export var offset: float

#바뀌는 요소
@export var best_score: float = 0

'''
func _init(bpm: float, path: String, artists: String, note_list: Array[NoteInfo], end_of_song: float) -> void:
	_bpm = bpm
	_path = path
	_artists = artists
	_note_list = note_list
	_end_of_song = end_of_song

func renew_best_score(score: float):
	_best_score = score
	
func reset_best_score(score: float):
	_best_score = 0
'''
