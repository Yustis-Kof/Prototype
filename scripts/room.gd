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
var state : States = States.FightPreparing:
	set(value):
		print("%s --> %s" % [States.find_key(state), States.find_key(value)])
		state = value
var units : Array[Entity]
var current_turn : int = -1
var current_unit : Entity

var current_move : Move
var current_path : Array[Movement] = []
var selectable_cells : Array[Cell]

signal cell_selected(cell : Cell)

func _ready() -> void:
	pass # Replace with function body.

func connect_ui() -> void:
	ui.StartButton.pressed.connect(start_fight)
	ui.EndTurnButton.pressed.connect(user_ended_turn)
	ui.EndTurnButton.disabled = true

func connect_field() -> void:
	field.cell_clicked.connect(on_cell_clicked) # Обрати внимание: они соединены постоянно

func start_fight() -> void:
	ui.StartButton.pressed.disconnect(start_fight)
	if state == States.FightPreparing:
		state = States.FightStart
	next_turn()

func next_turn() -> void:
	if units.size() < 1:
		end_fight()
		return
	current_turn = (current_turn + 1) % units.size()
	current_unit = units[current_turn]
	current_path = []
	field.highlight_path(current_path)
	ui.TurnTitle.text = "Ходит %s!" % current_unit.name
	if current_unit is Hero:
		ui.EndTurnButton.disabled = false
		
		var deck = current_unit.movedeck
		var move = Move.new()
		
		move.unit = current_unit
		move.room = self
		var dir = Direction.ALL.pick_random()
		move.append_character(StraightPattern.new(dir))
		move.append_character(ConstantDistance.new(randi_range(1,3)))
		if randi_range(1, 3) == 3:
			dir = Direction.ALL.pick_random()
			move.append_character(StarPattern.new(0b11111111))
			move.append_character(ConstantDistance.new(randi_range(1,3)))
		deck.append_move(move)
		
		ui.show_move_deck(deck)
		ui.move_selected.connect(on_move_selected)
		state = States.AwaitingUserInput

func user_ended_turn() -> void:
	ui.hide_move_deck()
	#ui.move_selected.disconnect(on_move_selected)
	ui.TurnTitle.text = "%s ходит..." % current_unit.name
	process_movement()

func process_movement() -> void:
	if current_path.size() == 0:
		next_turn()
		return
	current_unit.movement_ended.connect(on_movement_ended)
	current_unit.execute_movement(current_path[0])
	current_path.remove_at(0)

func end_fight() -> void:
	pass

func on_movement_ended():
	current_unit.movement_ended.disconnect(on_movement_ended)
	process_movement()

func on_move_selected(move : Move, deck : MoveDeck):
	for _move in deck.moves:
		_move.reset()
		if _move.move_finished.is_connected(on_move_finished):
			_move.move_finished.disconnect(on_move_finished)
	clear_cells_choice()
	current_move = move
	current_path = []
	move.move_finished.connect(on_move_finished)
	move.execute_next_character()

func on_cell_clicked(cell: Cell):
	if state != States.AwaitingCellSelect:
		return
	if cell not in selectable_cells:
		return
	clear_cells_choice()
	if ui.move_selected.is_connected(on_move_selected):
		ui.move_selected.disconnect(on_move_selected)	# После первого действия нельзя перевыбрать ход
		# TODO: Блок ходов во время хода (уже актуально ли?)
	
	current_path.append(Movement.new(cell))
	#current_unit.current_cell = cell
	
	cell_selected.emit(cell)
	field.highlight_path(current_path)
	#current_unit.movement_ended.connect(on_unit_ended_movement)
	ui.TurnTitle.text = "%s составляет ход..." % current_unit.name

func on_unit_ended_movement():
	ui.TurnTitle.text = "%s сходил!" % current_unit.name
	current_unit.movement_ended.disconnect(on_unit_ended_movement)
	#current_move.execute_next_character()

func on_move_finished():
	current_move.move_finished.disconnect(on_move_finished)
	current_move.reset()
	current_move = null
	#user_ended_turn()


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
		
		cell.highlight_mode = Cell.HighlightMode.Selectable
		cell.highlight()
		selectable_cells.append(cell)
	state = States.AwaitingCellSelect

func clear_cells_choice() -> void:
	for cell in selectable_cells:
		cell.unhighlight()
		#cell.selectable = false
	selectable_cells = []

func _process(delta: float) -> void:
	pass
