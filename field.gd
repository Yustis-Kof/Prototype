extends Node2D

@export var cell_texture : Texture2D
const CANVAS_ORIGIN : Vector2 = Vector2(-320, -320)
const WIDTH = 10
const HEIGHT = 10
const CELL_WIDTH : float = 64
const CELL_HEIGHT : float = 64
const CANVAS_SKEW : float = 0.6

var canvas_instance : RID
var count = 0

@onready var hero = $"../Hero"

func _ready() -> void:
	var tex_width : float = cell_texture.get_width()
	var tex_height : float = cell_texture.get_height()
	for i in range(WIDTH):
		for j in range(HEIGHT):
			var cell = Sprite2D.new()
			cell.texture = cell_texture
			cell.transform = Transform2D(0,
										Vector2(CELL_WIDTH/tex_width, CELL_HEIGHT/tex_height),
										0,
										Vector2(CANVAS_ORIGIN.x+i*CELL_WIDTH, CANVAS_ORIGIN.y+j*CELL_HEIGHT))
			add_child(cell)
			
			if i == hero.x and j == hero.y:
				print(hero.current_cell)
				hero.current_cell = cell

func get_cell(x : int, y : int):
	if x < 0 or x > WIDTH-1 or y < 0 or y > HEIGHT-1:
		return false
	var children = get_children()
	return children[WIDTH * x + y]

func _process(delta: float) -> void:
	count += PI/2 * delta
	skew = CANVAS_SKEW + sin(count)/20
