extends CharacterBody2D

signal death(area2D)

@onready var animated_sprite = $Sprite2D/PlayerAnimation

@onready var area2D = $Area2D

#constants for movement 
const SPEED = 300.0
const JUMP_VELOCITY = -300

# Get default gravity from project settings
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Create an AudioStreamPlayer node
var sound_player = AudioStreamPlayer.new()  
# Load the sound
var character_moving_sound = preload("res://Sounds/CharacterMoving.wav")

# Track if the character is moving for sound to play
var is_moving_left = false
var is_moving_right = false

func _ready():
	# Func to play the sound when player moves 
	sound_player.bus = "SFX"  
	sound_player.stream = character_moving_sound
	add_child(sound_player)
	
	animated_sprite.play("idle_right")



func _physics_process(delta):
	#add gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	#Handle jump
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("jump_idle")
	
	#Handle Left animations
	if Input.is_action_pressed("move_left"):
		if is_on_floor():
			animated_sprite.play("walk_left")
		if not is_on_floor():
			animated_sprite.play("jump_left")
		# Set the movement flag to true to indicate left movement
		is_moving_left = true
	else:
		if animated_sprite.assigned_animation == "walk_left":
			animated_sprite.stop()
			animated_sprite.play("idle_left")
		if animated_sprite.assigned_animation == "jump_left":
			animated_sprite.stop()
			animated_sprite.play("idle_left")
		# Set the movement flag to false to indicate no movement
		is_moving_left = false

	#Handle Right animations
	if Input.is_action_pressed("move_right"):
		if is_on_floor():
			animated_sprite.play("walk_right")
		if not is_on_floor():
			animated_sprite.play("jump_right")
		# Set the movement flag to true to indicate right movement
		is_moving_right = true
	else:
		if animated_sprite.assigned_animation == "walk_right":
			animated_sprite.stop()
			animated_sprite.play("idle_right")
		if animated_sprite.assigned_animation == "jump_right":
			animated_sprite.stop()
			animated_sprite.play("idle_right")
		# Set the movement flag to false to indicate no movement
		is_moving_right = false

	# Play the sound if character is moving left or right
	if is_moving_left or is_moving_right:
		if not sound_player.playing:
			sound_player.play()
	# Stop playing the sound when left or right keys are released
	else:
		if sound_player.playing:
			sound_player.stop()
	
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
	
func _on_animated_sprite_2d_animation_finished():
	animated_sprite.play("idle_right")

func _on_area_2d_area_entered(area):
	if(area.name == "Damage_Area"):
		area.get_parent().queue_free()
		death.emit(area2D)
	pass # Replace with function body.
