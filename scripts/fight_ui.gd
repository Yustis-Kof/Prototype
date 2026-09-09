class_name FightUI
extends Node2D
## Интерфейс битвы

@export var FightTitle : Label
@export var TurnTitle : Label
@export var StartButton : Button
@export var EndTurnButton : Button
@export var DeckContainer : BoxContainer

signal move_selected(move : Move)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func show_move_deck(deck : MoveDeck) -> void:
	DeckContainer.visible = true
	for move in deck.moves:
		var button = Button.new()
		button.pressed.connect(on_move_button_pressed.bind(move))
		button.text = move.get_spelling()
		DeckContainer.add_child(button)

func on_move_button_pressed(move : Move):
	move_selected.emit(move)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scale = Vector2.ONE / get_parent().zoom
