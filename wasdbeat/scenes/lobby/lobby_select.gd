extends Node2D
class_name LobbySelect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_lobby_main_request_move_to_lobby_select_to_lobby_select() -> void:
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(self, "position", Vector2(0,0), 0.5)
	pass # Replace with function body.


func _on_button_pressed() -> void:
	StageLoad.path = "res://scenes/music/music_scene/body_talk.tscn"
	StageLoad.score = 0
	StageLoad.music_name = "Body Talk"
	get_tree().change_scene_to_file("res://scenes/game_started/game_ui.tscn")
	pass # Replace with function body.
