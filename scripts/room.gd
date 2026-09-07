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
		deck.moves.append(Move.new())
		
		ui.show_move_deck(deck)
		state = States.AwaitingCellSelect

func end_fight() -> void:
	pass

func spawn(entity : Entity, x : int, y : int) -> void:
	## Заспавнить объект на поле
	if not field: return
	var cell = field.get_cell(x, y)
	if not cell: return
	
	entity.current_cell = cell
	add_child(entity)
	units.append(entity)

func on_cell_selected(cell: Cell):
	if state != States.AwaitingCellSelect:
		return
	current_unit.current_cell = cell
	state = States.UnitActing
	current_unit.movement_ended.connect(on_unit_ended_movement)
	ui.TurnTitle.text = "%s ходит..." % current_unit.name

func on_unit_ended_movement():
	ui.TurnTitle.text = "%s сходил!" % current_unit.name
	current_unit.movement_ended.disconnect(on_unit_ended_movement)
	next_move()

func _process(delta: float) -> void:
	pass
