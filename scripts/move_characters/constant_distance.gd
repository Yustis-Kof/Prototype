class_name ConstantDistance
extends Distance
## Константа в качестве дальности передвижения

var distance : int

func _init(_distance : int):
	distance = _distance

func get_distance() -> int:
	return distance

func get_symbol():
	return str(distance)
