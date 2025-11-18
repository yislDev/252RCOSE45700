extends Control
class_name GamePlatePanel

const SIZE: int = 75

var _on_notes: Array[Array] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clip_contents = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func generate_note() -> void:
	var note_high = NoteGenerator.generate(Vector2(0,-40))
	var note_low = NoteGenerator.generate(Vector2(0,SIZE +20))
	add_child(note_high)
	add_child(note_low)
	#note_high.top_level = true
	#note_low.top_level = true
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(note_high, "position", note_high.position + Vector2(0,SIZE/2) + Vector2(0,30), Game.TIME_NOTE_READY)
	#var tween2 = get_tree().create_tween().set_parallel(true)
	tween.tween_property(note_low, "position", note_low.position - Vector2(0,SIZE/2) - Vector2(0,30), Game.TIME_NOTE_READY)
	#tween.finished.connect(Callable("remove_note"))
	var timer = get_tree().create_tween().set_parallel(true)
	timer.tween_property(self, "position", position, Game.TIME_NOTE_READY+Game.TIME_NOTE_TOO_LATE)
	timer.connect("finished",Callable(self, "remove_note").bind(true))
	
	_on_notes.append([note_high,note_low,tween,timer])
	pass
	
func remove_note(late: bool = false) -> void:
	if (late == true):
		await get_tree().create_timer(Game.TIME_NOTE_TOO_LATE).timeout
	
	if (_on_notes.is_empty()):
		return
	else:
		var target: Array
		target = _on_notes.pop_front()
		target[0].queue_free()
		target[1].queue_free()
		target[2].kill()
		target[3].kill()
	pass

func remove_note_too_late() -> void:
	
	if (_on_notes.is_empty()):
		return
	else:
		var target: GameNote
		for i in range(2):
			target = _on_notes.pop_front()
			target.queue_free()
	pass
