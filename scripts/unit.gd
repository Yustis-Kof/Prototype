class_name Unit
extends Entity
## Игровой юнит

var movedeck : MoveDeck:
	set(value):
		movedeck = value
		add_child(movedeck)

func _ready() -> void:
	movedeck = MoveDeck.new()

func execute_movement(movement : Movement):
	current_cell = movement.to
