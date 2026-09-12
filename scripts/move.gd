class_name Move
extends Node
## Ход, определяющий передвижения и действия юнита

var characters : Array[MoveCharacter] ## Символы, из которых состоит ход
## TODO: Поддержка вложенных ходов
var unit : Unit
var room : Room:
	set(value):
		if room and room.ui.move_selected.is_connected(on_move_selected):
			room.ui.move_selected.disconnect(on_move_selected)
		room = value
		value.ui.move_selected.connect(on_move_selected)


var counter : int = -1 ## Указатель текущего символа
var current_char : MoveCharacter
var current_cell : Cell
var current_dir : Entity.FacingDirection
var current_pattern : MovementPattern

signal move_finished

func execute_next_character() -> void:
	counter += 1
	if counter == characters.size():
		move_finished.emit()
		reset()
		return
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
	room.cell_selected.connect(on_cell_selected)

func on_cell_selected(cell : Cell) -> void:
	current_cell = cell
	room.cell_selected.disconnect(on_cell_selected)
	execute_next_character()

func on_move_selected(move : Move, deck : MoveDeck):
	if move != self:
		if room.cell_selected.is_connected(on_cell_selected):
			room.cell_selected.disconnect(on_cell_selected)

func reset() -> void:
	counter = -1
	current_char = null
	current_cell = room.field.get_cell(unit.x, unit.y)
	#current_dir = null ?
	current_pattern = null


func append_character(character : MoveCharacter):
	character.move = self
	characters.append(character)
	
	
func get_spelling():
	var string = ""
	for character in characters:
		string += character.symbol
	return string
	
	
