@abstract class_name MovementPattern
extends MoveCharacter
## Символ, переназначающий паттерн следующего передвижения

var unit : Unit
var room : Room
var default_movement_type : Entity.MovementType

func get_cells(min_distance : int, max_distance : int, facing : Entity.FacingDirection) -> Array[Vector2i]:
	## Получить массив относительных координат паттерна
	return []
