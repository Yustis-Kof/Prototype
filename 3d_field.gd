extends Node3D

@export var cell_texture : Texture2D
const CANVAS_ORIGIN : Vector2 = Vector2(-6.4, -6.4)
const WIDTH = 10
const HEIGHT = 10
const CELL_WIDTH : float = 1.28
const CELL_HEIGHT : float = 1.28
const CANVAS_SKEW : float = 0.6

var canvas_instance : RID
var count = 0

func _ready() -> void:
	var tex_width : float = cell_texture.get_width()
	var tex_height : float = cell_texture.get_height()
	for i in range(WIDTH):
		for j in range(HEIGHT):
			var cell = Sprite3D.new()
			cell.texture = cell_texture
			cell.transform = Transform3D(Basis(Vector3(1, 0, 0), deg_to_rad(90)),
										Vector3(CANVAS_ORIGIN.x+i*CELL_WIDTH, 0, CANVAS_ORIGIN.y+j*CELL_HEIGHT))
										#Vector3(CELL_WIDTH/tex_width, CELL_HEIGHT/tex_height, 1),
			add_child(cell)
			

func get_cell(x : int, y : int):
	if x < 0 or x > WIDTH-1 or y < 0 or y > HEIGHT-1:
		return false
	var children = get_children()
	return children[WIDTH * x + y]

func _process(delta: float) -> void:
	pass
