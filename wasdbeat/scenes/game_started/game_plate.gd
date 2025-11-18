extends Node2D
class_name GamePlate

@export var panel_list: Array[GamePlatePanel]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#var panel_index_x: int
#var panel_index_y: int
func _on_game_request_generate_note(panel_index: int) -> void:
	panel_list[panel_index].generate_note()
	pass # Replace with function body.

func _on_game_request_remove_note(panel_index: Variant) -> void:
	panel_list[panel_index].remove_note()
	pass # Replace with function body.

func _on_game_request_move_player(player_location: Vector2) -> void:
	$PlayerBox.move(player_location)
	pass # Replace with function body.
