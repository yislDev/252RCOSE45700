extends Control
class_name PlayerBox

const PANEL_SIZE: int = 75
const PANEL_OFFSET: int = 2
const BOX_SIZE: int = 79

var location: Vector2 = Vector2(0,0)
var position_offset: Vector2 = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	location = Vector2(0,0)
	#position_offset = Vector2(BOX_SIZE/2, BOX_SIZE/2)
	update_position()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func move(player_location) -> void:
	location = player_location
	update_position()
	pass

func move_left(num_columns: int = 4) -> void:
	location.y -= 1
	if (location.y <= -1):
		location.y = num_columns-1
	update_position()
	pass

func move_right(num_columns: int = 4) -> void:
	location.y += 1
	if (location.y >= num_columns):
		location.y = 0
	update_position()
	pass
	
func move_up(num_rows: int = 4) -> void:
	location.x -= 1
	if (location.x <= -1):
		location.x = num_rows-1
	update_position()
	pass
	
func move_down(num_rows: int = 4) -> void:
	location.x += 1
	if (location.x >= num_rows):
		location.x = 0
	update_position()
	pass

func update_position() -> void:
	position = position_offset + Vector2(location.y * (PANEL_SIZE + PANEL_OFFSET), location.x * (PANEL_SIZE + PANEL_OFFSET))
	pass
