class_name Cell
extends Area2D

var texture : Texture2D:
	set(value):
		texture = value
		if sprite:
			sprite.texture = value

var sprite : Sprite2D = Sprite2D.new() 
var hitbox : CollisionShape2D = CollisionShape2D.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.material = ShaderMaterial.new()
	#sprite.material.shader = load("res://shaders/circle.gdshader")
	sprite.material.set_shader_parameter("radius", 0.0)
	hitbox.shape = RectangleShape2D.new()
	hitbox.shape.size = Vector2(128, 128)
	add_child(sprite)
	add_child(hitbox)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered() -> void:
	sprite.material.shader = load("res://shaders/circle.gdshader")
	sprite.material.set_shader_parameter("radius", 0.5)
	modulate.a = 0.1

func _on_mouse_exited() -> void:
	#sprite.material.set_shader_parameter("radius", 0.0)
	modulate.a = 1

func circle() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
