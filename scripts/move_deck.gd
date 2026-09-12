class_name MoveDeck
extends Node
## Колода ходов, которыми владеет юнит

var moves : Array[Move]


func append_move(move : Move):
	moves.append(move)
	add_child(move)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
