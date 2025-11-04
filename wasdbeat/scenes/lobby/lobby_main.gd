extends Node2D
class_name LobbyMain

signal request_move_to_lobby_select()
signal request_move_to_escape_game()
signal request_not_to_escape()
signal request_escape_game()

enum GAMESTATE {LOBBY_MAIN, LOBBY_ESCAPE, LOBBY_SELECT}
var game_state

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_state = GAMESTATE.LOBBY_MAIN
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# ESC pressed
	
	print(game_state)
	if (game_state == GAMESTATE.LOBBY_MAIN):
		if (Input.is_action_just_pressed("key_escape")):
			set_game_state(GAMESTATE.LOBBY_ESCAPE)
			request_move_to_escape_game.emit()
			pass
		elif (Input.is_action_just_pressed("key_enter")):
			set_game_state(GAMESTATE.LOBBY_SELECT)
			request_move_to_lobby_select.emit()
			pass
	elif (game_state == GAMESTATE.LOBBY_ESCAPE):
		if (Input.is_action_just_pressed("key_escape")):
			request_not_to_escape.emit()
			pass
		elif (Input.is_action_just_pressed("key_enter")):
			request_escape_game.emit()
			pass
	pass
	
func set_game_state(state_to_set):
	game_state = state_to_set
	$LobbyEscape.game_state = state_to_set

func _on_request_move_to_escape_game() -> void:
	if (game_state != GAMESTATE.LOBBY_ESCAPE):
		request_not_to_escape.emit()
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property($LobbyEscape, "position", Vector2(576,324), 0.5)
	pass


func _on_request_not_to_escape() -> void:
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property($LobbyEscape, "position", Vector2(576, -324), 0.5)
	set_game_state(GAMESTATE.LOBBY_MAIN)
	pass


func _on_lobby_escape_request_game_escape() -> void:
	set_game_state(GAMESTATE.LOBBY_MAIN)
	get_tree().quit()
	pass # Replace with function body.
