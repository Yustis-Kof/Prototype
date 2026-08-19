extends Camera2D

var hor_speed = 5
var vert_speed = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var horizontal_movement = Input.get_action_strength("right") - Input.get_action_strength("left")
	var vertical_movement = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	position.x += hor_speed * horizontal_movement
	position.y += vert_speed * vertical_movement
