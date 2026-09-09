class_name Move
extends Node
## Ход, определяющий передвижения и действия юнита

var characters : Array[MoveCharacter] ## Символы, из которых состоит ход
## TODO: Поддержка вложенных ходов
var unit : Unit
var room : Room

var counter : int = -1 ## Указатель текущего символа
var current_char : MoveCharacter
var current_dir : Entity.FacingDirection
var current_pattern : MovementPattern

func execute_next_character() -> void:
	counter += 1
	current_char = characters[counter]
	if current_char is MovementPattern:
		process_pattern()
		return execute_next_character()
	elif current_char is Distance:
		return process_distance()
	return

func process_pattern() -> void:
	current_char.unit = unit
	current_char.room = room
	current_pattern = current_char

func process_distance() -> void:
	var max_distance = current_char.get_distance()
	var min_distance = max_distance
	
	var cells = current_pattern.get_cells(min_distance, max_distance, current_dir)
	room.set_cells_choice(cells)
	
func get_spelling():
	var string = ""
	for character in characters:
		string += character.symbol
	return string
	
	
