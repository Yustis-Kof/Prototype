class_name Entity
extends Node2D
## Сущность, занимающая место на игровом поле

@export var current_cell : Cell:
	set(value):
		current_cell = value
		x = value.x
		y = value.y
@export var sprite : Node2D

enum FacingDirection {
	Right,
	Down,
	Left,
	Up
}


var x : int
var y : int
var speed : float
var facing : FacingDirection
var current_movement_type : Movement.MovementType

signal movement_started
signal movement_ended

func _ready() -> void:
	pass

func set_sprite(_sprite: Node2D, _scale: float = 1.0, offset : Vector2 = Vector2.ZERO):
	sprite = _sprite
	sprite.scale = Vector2(_scale, _scale)
	if sprite is Sprite2D and offset == Vector2.ZERO:
		sprite.position = -sprite.texture.get_height() / 2.0
	else:
		sprite.position = offset
	
	
	
	add_child(sprite)

func _process(delta: float) -> void:
	if current_cell:
		position.x += (current_cell.global_position.x - position.x)/4
		position.y += (current_cell.global_position.y - position.y)/4
		if abs(position - current_cell.global_position) < Vector2.ONE:
			movement_ended.emit()
