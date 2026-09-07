class_name Room
extends Node2D

@export var field : Field
@export var ui : FightUI

enum States {
	FightPreparing,
	FightStart,
	AwaitingUserInput,
	UnitActing,
	FightEnd
}
var state : States = States.FightPreparing
var units : Array[Entity]
var current_turn : int = -1

func _ready() -> void:
	pass # Replace with function body.

func connect_ui() -> void:
	ui.StartButton.pressed.connect(start_fight)
	ui.EndTurnButton.pressed.connect(next_move)
	ui.EndTurnButton.disabled = true

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
	var current_unit = units[current_turn]
	ui.TurnTitle.text = "Ходит %s!" % current_unit.name

	if current_unit is Hero:
		ui.EndTurnButton.disabled = false
		state = States.AwaitingUserInput

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


func _process(delta: float) -> void:
	pass
