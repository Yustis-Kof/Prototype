class_name StarPattern
extends MovementPattern
## Паттерн из от 1 до 8 лучей

var directions : Array[Vector2]

func _init(_directions : int):
	## Можно задать с помощью 0b11111111
	var i = 0
	while _directions > 0 and i < 8:
		if _directions % 2 == 1:
			directions.append(Direction.ALL[-i])
		_directions = _directions >> 1
		i += 1

func get_cells(min_distance : int, max_distance : int, facing : Entity.FacingDirection) -> Array[Vector2i]:
	var cells : Array[Vector2i] = []
	for dir in directions:
		var ray = Ray.new(min_distance, max_distance, dir)
		cells += room.ray_to_cells(Vector2i(move.current_cell.x, move.current_cell.y), ray)
	return cells

func get_symbol():
	return "*"
