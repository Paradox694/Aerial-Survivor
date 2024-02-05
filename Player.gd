extends CharacterBody2D

#constants for movement 
const SPEED = 300.0
const JUMP_VELOCITY = -400

# Get default gravity from project settings
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	#add gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	#Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#Handle input for left and right movement 
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		# Move right if direction is positive, move left if negative
		velocity.x = direction * SPEED
	else:
		 # Slow down if no input for smoother movement
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	  # Move the character based on the calculated velocity
	move_and_slide()
