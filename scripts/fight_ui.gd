class_name FightUI
extends Node2D
## Интерфейс битвы

@export var FightTitle : Label
@export var TurnTitle : Label
@export var StartButton : Button
@export var EndTurnButton : Button
@export var DeckContainer : BoxContainer

var current_deck : MoveDeck

signal move_selected(move : Move, deck : MoveDeck)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func show_move_deck(deck : MoveDeck) -> void:
	current_deck = deck
	DeckContainer.visible = true
	for move in deck.moves:
		var button = MoveButton.new()
		button.move = move
		button.pressed.connect(on_move_button_pressed.bind(button))
		button.text = move.get_spelling()
		DeckContainer.add_child(button)

func hide_move_deck() -> void:
	for button in DeckContainer.get_children():
		button.queue_free()
	DeckContainer.visible = false

func on_move_button_pressed(button : MoveButton):
	for _button in DeckContainer.get_children():
		if _button != button:
			_button.button_pressed = false
	move_selected.emit(button.move, current_deck)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scale = Vector2.ONE / get_parent().zoom

class MoveButton extends Button:
	## Кнопка выбора хода
	var move : Move
	
	func _ready():
		toggle_mode = true
