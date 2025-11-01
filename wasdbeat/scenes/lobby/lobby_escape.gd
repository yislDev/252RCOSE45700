extends Node2D
class_name LobbyEscape

signal request_game_escape()
signal request_game_continue()
signal request_get_game_state()

enum GAMESTATE {LOBBY_MAIN, LOBBY_ESCAPE, LOBBY_SELECT}
var game_state

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_state = GAMESTATE.LOBBY_MAIN
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if ((game_state == GAMESTATE.LOBBY_ESCAPE) and Input.is_action_just_pressed("key_escape")):
	#	request_game_continue.emit()
	pass


func _on_escape_yes_button_up() -> void:
	request_game_escape.emit()
	pass # Replace with function body.


func _on_escape_no_button_up() -> void:
	request_game_continue.emit()
	pass # Replace with function body.
