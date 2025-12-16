extends Node2D

var offset: int = 0

signal change_offset(offset: float)

func _on_button_left_pressed() -> void:
	offset -= 10
	change_offset.emit(offset)
	pass # Replace with function body.


func _on_button_right_pressed() -> void:
	offset += 10
	change_offset.emit(offset)
	pass # Replace with function body.
	
func change_offset_fun() -> void:
	change_offset.emit(offset)
