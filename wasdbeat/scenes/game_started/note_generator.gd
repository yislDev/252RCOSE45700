extends Node
class_name NoteGenerator

const game_note = "res://scenes/game_started/game_note.tscn"

static func generate(position_to_set: Vector2) -> GameNote:
	var inst: GameNote = preload(game_note).instantiate() as GameNote
	inst.position = position_to_set
	return inst
