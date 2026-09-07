class_name FightUI
extends Node2D
## Интерфейс битвы

@export var FightTitle : Label
@export var TurnTitle : Label
@export var StartButton : Button
@export var EndTurnButton : Button
@export var DeckContainer : BoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func show_move_deck(deck : MoveDeck) -> void:
	DeckContainer.visible = true
	for move in deck.moves:
		var button = Button.new()
		button.text = "bitch"
		DeckContainer.add_child(button)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scale = Vector2.ONE / get_parent().zoom
