class_name Ray
extends Object
## Луч в ортогональном пространстве

var min_distance : int
var max_distance : int
var direction : Vector2

func _init(_min_distance : int, _max_distance : int, _direction : Vector2):
	min_distance = _min_distance
	max_distance = _max_distance
	direction = _direction
