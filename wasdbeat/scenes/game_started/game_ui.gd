extends Node2D
class_name GameUI

signal request_move_player(dir: DIR)

enum DIR {
	DOWN,
	UP,
	RIGHT,
	LEFT
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Pause.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("key_down")):
		request_move_player.emit(DIR.DOWN)
	if (Input.is_action_just_pressed("key_up")):
		request_move_player.emit(DIR.UP)
	if (Input.is_action_just_pressed("key_right")):
		request_move_player.emit(DIR.RIGHT)
	if (Input.is_action_just_pressed("key_left")):
		request_move_player.emit(DIR.LEFT)
	if (Input.is_action_just_pressed("key_escape")):
		$Pause.show()
		get_tree().paused = true
	pass


func _on_resume_pressed() -> void:
	$Pause.hide()
	get_tree().paused = false
	pass # Replace with function body.
