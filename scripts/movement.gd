class_name Movement
extends Node
## Передвижение с одной клетки на другую

enum MovementType {
	Dash,	# Рывок
	Path,	# Перемещение по соседним клеткам по наикратчайшему пути
	Jump,
	Teleport,
}

var to : Cell
var type : MovementType

func _init(_to : Cell, _type : MovementType = MovementType.Dash) -> void:
		to = _to
		type = _type
