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
		if $Rig.scale.x != abs($Rig.scale.x) * direction:
			$Rig.scale.x = abs($Rig.scale.x) * direction
			print(direction)
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	animation_player.speed_scale = 1
	
	if velocity.y < 0:
		start_animation("lift", 0.2)
	elif velocity.y > 0:
		start_animation("fall", 0.5)
	elif velocity.x:
		animation_player.play("walk", 1)
		animation_player.speed_scale = abs(velocity.x/WALK_ANIMATION_BASIC_SPEED)
	else:
		start_animation("rest", 0.5)
		
	if Input.is_action_just_pressed("ui_down"):
		start_animation("rest", 1)
	
	if randi_range(1, 1000) == 1:
		animation_player.play("idle_1", 1)

	move_and_slide()

func start_animation(animation : String, blend_time : float = -1):
	if animation_player.current_animation != animation:
		animation_player.play(animation, blend_time)
