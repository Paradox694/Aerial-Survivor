extends CharacterBody2D

# Exported variables for customization
@export var MAX_SPEED = 200
@export var ACCELERATION = 1000
@export var FRICTION = 1200

# Onready variable to store input axis
@onready var axis = Vector2.ZERO

# Main physics process function
func _physics_process(delta):
	move(delta)

# Function to get input axis (left/right movement)
func get_input_axis():
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	return axis.normalized()

# Function to handle movement based on input
func move(delta):

	axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction(FRICTION * delta)

	else:
		apply_movement(axis * ACCELERATION * delta)

	move_and_slide()

# Function to apply friction to slow down movement
func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

# Function to apply movement acceleration
func apply_movement(accel):
	velocity += accel
	velocity = velocity.limit_length(MAX_SPEED)
