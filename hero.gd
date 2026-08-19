extends Sprite2D

@export var current_cell : Sprite2D
@onready var field = $"../Field"

var hor_speed = 5
var vert_speed = 5

var x : int = 5
var y : int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_cell:
		position.x += (current_cell.global_position.x - position.x)/2
		position.y += (current_cell.global_position.y - position.y)/2
	
	var hor_movement = 0
	var vert_movement = 0
	if Input.is_action_just_pressed("ui_left"):
		hor_movement = -1
	if Input.is_action_just_pressed("ui_right"):
		hor_movement = 1
	if Input.is_action_just_pressed("ui_up"):
		vert_movement = -1
	if Input.is_action_just_pressed("ui_down"):
		vert_movement = 1
	
	
	var next_x = x + hor_movement
	var next_y = y + vert_movement
	
	var next_cell = field.get_cell(next_x, next_y)
	if next_cell:
		current_cell = next_cell
		x = next_x
		y = next_y
