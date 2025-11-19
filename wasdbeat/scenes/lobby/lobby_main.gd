extends Node2D
class_name LobbyMain

signal request_not_to_escape_to_lobby_ui
signal request_escape_to_lobby_ui
signal request_move_to_lobby_select_to_lobby_select

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#게임 종료 (quit)
func _on_lobby_ui_request_escape_game() -> void:
	get_tree().quit()
	pass # Replace with function body.

#게임 종료 창 띄우기
func _on_lobby_ui_request_move_to_lobby_main_escape() -> void:
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property($LobbyEscape, "position", Vector2(576,324), 0.5)
	pass # Replace with function body.

#게임 종료 창 없애기
func _on_lobby_ui_request_not_to_escape_from_lobby_main() -> void:
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property($LobbyEscape, "position", Vector2(576, -324), 0.5)
	pass # Replace with function body.

#선택 창으로 이동하기
func _on_lobby_ui_request_move_to_lobby_select() -> void:
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(self, "position", Vector2(0,-648), 0.5)
	request_move_to_lobby_select_to_lobby_select.emit()
	pass # Replace with function body.

#게임 종료 ui에게 전달하기
func _on_lobby_escape_request_game_escape() -> void:
	request_escape_to_lobby_ui.emit()
	pass # Replace with function body.

#게임 컨티뉴 ui에게 전달하기
func _on_lobby_escape_request_game_continue() -> void:
	request_not_to_escape_to_lobby_ui.emit()
	pass # Replace with function body.
