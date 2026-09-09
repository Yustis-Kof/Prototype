class_name Room
extends Node2D

@export var field : Field
@export var ui : FightUI

enum States {
	FightPreparing,
	FightStart,
	AwaitingUserInput,
	AwaitingCellSelect,
	UnitActing,
	FightEnd
}
var state : States = States.FightPreparing
var units : Array[Entity]
var current_turn : int = -1
var current_unit : Entity

var current_selectable_cells : Array[Cell]

func _ready() -> void:
	pass # Replace with function body.

func connect_ui() -> void:
	ui.StartButton.pressed.connect(start_fight)
	ui.EndTurnButton.pressed.connect(next_move)
	ui.EndTurnButton.disabled = true

func connect_field() -> void:
	field.cell_clicked.connect(on_cell_selected) # Обрати внимание: они соединены постоянно

func start_fight() -> void:
	ui.StartButton.pressed.disconnect(start_fight)
	if state == States.FightPreparing:
		state = States.FightStart
	next_move()

func next_move() -> void:
	if units.size() < 1:
		end_fight()
		return
	current_turn = current_turn + 1 % units.size()
	current_unit = units[current_turn]
	ui.TurnTitle.text = "Ходит %s!" % current_unit.name
	if current_unit is Hero:
		ui.EndTurnButton.disabled = false
		
		var deck = MoveDeck.new()
		var move = Move.new()
		move.unit = current_unit
		move.room = self
		var dirs = []
		for i in range(9):
			dirs.append(Vector2(i%3-1, (i-3)/3))
		print(dirs)
		var dir = dirs.pick_random()
		move.characters.append(StraightPattern.new(dir))
		move.characters.append(ConstantDistance.new(1))
		deck.moves.append(move)
		
		ui.show_move_deck(deck)
		ui.move_selected.connect(on_move_selected)
		state = States.AwaitingUserInput

func end_fight() -> void:
	pass

func on_move_selected(move : Move):
	move.execute_next_character()

func on_cell_selected(cell: Cell):
	if state != States.AwaitingCellSelect:
		return
	if cell not in current_selectable_cells:
		return
	clear_cells_choice()
	current_unit.current_cell = cell
	state = States.UnitActing
	current_unit.movement_ended.connect(on_unit_ended_movement)
	ui.TurnTitle.text = "%s ходит..." % current_unit.name

func on_unit_ended_movement():
	ui.TurnTitle.text = "%s сходил!" % current_unit.name
	current_unit.movement_ended.disconnect(on_unit_ended_movement)
	next_move()



func spawn(entity : Entity, x : int, y : int) -> void:
	## Заспавнить объект на поле
	if not field: return
	var cell = field.get_cell(x, y)
	if not cell: return
	
	entity.current_cell = cell
	add_child(entity)
	units.append(entity)

func ray_to_cells(origin : Vector2i, ray : Ray) -> Array[Vector2i]:
	## Получить клетки из начальной клетки и луча
	var cells : Array[Vector2i] = []
	var i = ray.min_distance
	while i <= ray.max_distance:
		var coords = origin + Vector2i(ray.direction * i)
		var cell = field.get_cell(coords.x, coords.y)
		if cell:
			cells.append(Vector2i(coords.x, coords.y))
		i += 1
	return cells

func set_cells_choice(cells : Array[Vector2i]):
	## Задать клетки, которые можно выбрать
	for coords in cells:
		var cell = field.get_cell(coords.x, coords.y)
		cell.highlight()
		cell.selectable = true
		current_selectable_cells.append(cell)
	state = States.AwaitingCellSelect

func clear_cells_choice() -> void:
	for cell in current_selectable_cells:
		cell.unhighlight()
		cell.selectable = false
	current_selectable_cells = []

func _process(delta: float) -> void:
	pass
