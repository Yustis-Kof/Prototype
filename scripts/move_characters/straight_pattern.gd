class_name StraightPattern
extends MovementPattern
## Паттерн передвижения по прямой

var direction : Vector2

var direction_symbols = {
	Direction.E  : "→",
	Direction.SE : "↘",
	Direction.S  : "↓",
	Direction.SW : "↙",
	Direction.W  : "←",
	Direction.NW : "↖",
	Direction.N  : "↑",
	Direction.NE : "↗",
}

func _init(_direction : Vector2):
	direction = _direction

func get_cells(min_distance : int, max_distance : int, facing : Entity.FacingDirection) -> Array[Vector2i]:
	var ray = Ray.new(min_distance, max_distance, direction)
	return room.ray_to_cells(Vector2i(move.current_cell.x, move.current_cell.y), ray)

func get_symbol():
	return direction_symbols[direction]
