extends Node2D
class_name LobbyUI

signal request_move_to_lobby_select()
signal request_move_to_lobby_main_escape()
signal request_not_to_escape_from_lobby_main()
signal request_escape_game()

enum GAMESTATE {LOBBY_MAIN, LOBBY_MAIN_ESCAPE, LOBBY_SELECT, LOBBY_SELECT_ESCAPE, LOBBY_OPTION}
var game_state
var game_state_temp

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_state = GAMESTATE.LOBBY_MAIN
	game_state_temp = GAMESTATE.LOBBY_MAIN
	$Option.position = Vector2(1152,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(game_state)
	
	if (game_state == GAMESTATE.LOBBY_MAIN):
		if (Input.is_action_just_pressed("key_escape")):
			set_game_state(GAMESTATE.LOBBY_MAIN_ESCAPE)
			request_move_to_lobby_main_escape.emit()
			pass
		elif (Input.is_action_just_pressed("key_enter")):
			set_game_state(GAMESTATE.LOBBY_SELECT)
			request_move_to_lobby_select.emit()
			pass
	
	elif (game_state == GAMESTATE.LOBBY_MAIN_ESCAPE):
		if (Input.is_action_just_pressed("key_escape")):
			set_game_state(GAMESTATE.LOBBY_MAIN)
			request_not_to_escape_from_lobby_main.emit()
			pass
		elif (Input.is_action_just_pressed("key_enter")):
			request_escape_game.emit()
			pass
	
	elif (game_state == GAMESTATE.LOBBY_SELECT):
		pass
	elif (game_state == GAMESTATE.LOBBY_SELECT_ESCAPE):
		pass
	
	pass

func set_game_state(state_to_set):
	game_state = state_to_set


func _on_lobby_main_request_escape_to_lobby_ui() -> void:
	request_escape_game.emit()
	pass # Replace with function body.


func _on_lobby_main_request_not_to_escape_to_lobby_ui() -> void:
	set_game_state(GAMESTATE.LOBBY_MAIN)
	request_not_to_escape_from_lobby_main.emit()
	pass # Replace with function body.


func _on_lobby_option_pressed() -> void:
	game_state_temp = game_state
	set_game_state(GAMESTATE.LOBBY_OPTION)
	$Option.position = Vector2(0,0)
	pass # Replace with function body.


func _on_option_done_pressed() -> void:
	set_game_state(game_state_temp)
	game_state_temp = GAMESTATE.LOBBY_MAIN
	$Option.position = Vector2(1152,0)
	pass # Replace with function body.
