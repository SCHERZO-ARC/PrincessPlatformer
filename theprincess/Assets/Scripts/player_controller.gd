extends CharacterBody2D
class_name PlayerController

@export var speed = 10.0
@export var jump_power = 10.0
@onready var sfx_jump: AudioStreamPlayer2D = $sfx_jump


var speed_multiplier = 30.0
var jump_multiplier = -30.0
var direction = 0
var jump_count = 0
var max_jumps = 2


func _input(event):
	
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = jump_multiplier / 4
	
	if is_on_floor():
		jump_count = 0
	if event.is_action_pressed("jump") and jump_count < max_jumps:
		velocity.y = jump_power * jump_multiplier
		sfx_jump.play()
		jump_count += 1
	if event.is_action_pressed("move_down"):
		set_collision_mask_value(10, false)
	else:
		set_collision_mask_value(10, true)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)

	move_and_slide()
