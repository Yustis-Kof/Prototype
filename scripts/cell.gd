class_name Cell
extends Area2D

var texture : Texture2D:
	set(value):
		texture = value
		if sprite:
			sprite.texture = value

var field : Field
var sprite : Sprite2D = Sprite2D.new() 
var hitbox : CollisionShape2D = CollisionShape2D.new()

var x : int
var y : int

var selectable : bool = false

func _ready() -> void:
	sprite.material = ShaderMaterial.new()
	sprite.material.shader = load("res://shaders/circle.gdshader")
	sprite.material.set_shader_parameter("radius", 0.0)
	hitbox.shape = RectangleShape2D.new()
	hitbox.shape.size = Vector2(128, 128)
	add_child(sprite)
	add_child(hitbox)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	input_event.connect(_on_input_event)


func highlight() -> void:
	## Подсветить клетку
	sprite.material.set_shader_parameter("start", true)
	sprite.material.set_shader_parameter("radius", 0.3)

func unhighlight() -> void:
	## Сбросить подсветку
	sprite.material.set_shader_parameter("start", false)
	sprite.material.set_shader_parameter("radius", 0.0)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == 1:
		field.cell_clicked.emit(self)	# Надеюсь, мне не аукнется то, что я соединяю это не через сигнал
		if event.pressed:
			sprite.material.set_shader_parameter("start", true)
		else:
			sprite.material.set_shader_parameter("start", false)
	

func _on_mouse_entered() -> void:
	#sprite.material.shader = load("res://shaders/circle.gdshader")
	#sprite.material.set_shader_parameter("radius", 0.5)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		sprite.material.set_shader_parameter("start", true)
	if selectable:
		modulate.a = 0.1

func _on_mouse_exited() -> void:
	#sprite.material.set_shader_parameter("radius", 0.0)
	if not selectable:
		sprite.material.set_shader_parameter("start", false)
	modulate.a = 1

func circle() -> void:
	pass

func _process(delta: float) -> void:
	pass
