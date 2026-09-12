class_name Unit
extends Entity
## Игровой юнит

var target_cell : Cell
var movedeck : MoveDeck:
	set(value):
		movedeck = value
		add_child(movedeck)

func _ready() -> void:
	movedeck = MoveDeck.new()
	movement_started.connect(on_movement_started)

func execute_movement(movement : Movement) -> void:
	target_cell = movement.to
	current_movement_type = movement.type
	movement_started.emit()
	
func on_movement_started() -> void:
	if current_movement_type == Movement.MovementType.Dash:
		sprite.add_animation("dash_prepare")
		sprite.animation_ended.connect(on_animation_ended)

func on_animation_ended(animation : String) -> void:
	if animation == "dash_prepare":
		sprite.animation_ended.disconnect(on_animation_ended)
		current_cell = target_cell
		sprite.add_animation("dash")
		movement_ended.connect(on_movement_ended)

func on_movement_ended() -> void:
	sprite.skip()
	sprite.add_animation("dash_end")
	movement_ended.disconnect(on_movement_ended)
