extends CharacterBody2D

signal death(area2D, player_id)

@onready var animated_sprite = $Sprite2D/PlayerAnimation

@onready var area2D = $Area2D

@export var player_id = 0


#constants for movement 
const SPEED = 300.0
const JUMP_VELOCITY = -300

# Get default gravity from project settings
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animated_sprite.play("idle_right")

func _physics_process(delta):
		
	#add gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	#Handle jump
	if Input.is_action_pressed("jump_%s" % [player_id]) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("jump_idle")
	
	#Handle Left animations
	if Input.is_action_pressed("move_left_%s" % [player_id]):
		if is_on_floor():
			animated_sprite.play("walk_left")
		if not is_on_floor():
			animated_sprite.play("jump_left")
	else:
		if animated_sprite.assigned_animation == "walk_left":
			animated_sprite.stop()
			animated_sprite.play("idle_left")
		if animated_sprite.assigned_animation == "jump_left":
			animated_sprite.stop()
			animated_sprite.play("idle_left")
	
	#Handle Right animations
	if Input.is_action_pressed("move_right_%s" % [player_id]):
		if is_on_floor():
			animated_sprite.play("walk_right")
		if not is_on_floor():
			animated_sprite.play("jump_right")
	else:
		if animated_sprite.assigned_animation == "walk_right":
			animated_sprite.stop()
			animated_sprite.play("idle_right")
		if animated_sprite.assigned_animation == "jump_right":
			animated_sprite.stop()
			animated_sprite.play("idle_right")
	
	#Handle input for left and right movement 
	var direction = Input.get_axis("move_left_%s" % [player_id], "move_right_%s" % [player_id])
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
		death.emit(area2D, player_id)
	pass # Replace with function body.

func _on_area_2d_2_area_entered(area):
	if(area.name == "KillBox"):
		area.get_parent().queue_free()
		death.emit(area2D, player_id)
	pass # Replace with function body.
