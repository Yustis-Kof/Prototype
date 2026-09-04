class_name Field
extends Node2D

@export var cell_texture : Texture2D
const CANVAS_ORIGIN : Vector2 = Vector2(-320, -320)
const WIDTH = 10
const HEIGHT = 10
const CELL_WIDTH : float = 64
const CELL_HEIGHT : float = 64
const CANVAS_SKEW : float = 0.6
const ANIMATION_SPEED : float = 0.5

var current_animation_speed = ANIMATION_SPEED
var canvas_instance : RID
var count = 0

func _ready() -> void:
	var tex_width : float = cell_texture.get_width()
	var tex_height : float = cell_texture.get_height()
	for i in range(WIDTH):
		for j in range(HEIGHT):
			var cell = Cell.new()
			cell.texture = cell_texture
			cell.transform = Transform2D(0,
										Vector2(CELL_WIDTH/tex_width, CELL_HEIGHT/tex_height),
										0,
										Vector2(CANVAS_ORIGIN.x+i*CELL_WIDTH, CANVAS_ORIGIN.y+j*CELL_HEIGHT))
			add_child(cell)

func get_cell(x : int, y : int):
	if x < 0 or x > WIDTH-1 or y < 0 or y > HEIGHT-1:
		return false
	var children = get_children()
	return children[WIDTH * x + y]

func _process(delta: float) -> void:
	count += PI * current_animation_speed * delta
	skew = CANVAS_SKEW + sin(count) * 0.05
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		current_animation_speed = move_toward(current_animation_speed, 0, 0.5*delta)
	else:
		current_animation_speed = move_toward(current_animation_speed, ANIMATION_SPEED, 0.5*delta)
