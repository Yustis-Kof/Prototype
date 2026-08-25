extends CharacterBody2D

@onready var animation_player = $AnimationPlayer

const SPEED = 240
const JUMP_VELOCITY = -400.0

const WALK_ANIMATION_BASIC_SPEED = 80

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		$Rig.scale.x = abs($Rig.scale.x) * direction
		print(direction)
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x:
		animation_player.play("walk", 1)
		animation_player.speed_scale = abs(velocity.x/WALK_ANIMATION_BASIC_SPEED)
	else:
		animation_player.play("RESET", 1)

	move_and_slide()
