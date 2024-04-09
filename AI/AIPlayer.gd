extends CharacterBody2D

signal death(area2D, player_id)

@export var player_id = 0

@onready var animated_sprite = $Sprite2D/PlayerAnimation2

@onready var area2D = $Area2D

#signal highestPointOffset()

#constants for movement 
const SPEED = 300.0
const JUMP_VELOCITY = -300

# Get default gravity from project settings
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var jump : bool = false
var moveDirection : int = 0

var targetOffset = 20

var death_sound_player = AudioStreamPlayer2D.new() 
# Load death sound
var death_sound = preload("res://CharacterDamaged.wav") 


@export var AIGridOffset : int

func _ready():
	animated_sprite.play("idle_right")

func _physics_process(delta):
	#add gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	#Handle jump
	if jump and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("jump_idle")
		jump = false
	
	#Handle Left animations
	if moveDirection < 0:
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
	if moveDirection > 0:
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
	#var direction = Input.get_axis("move_left", "move_right")
	
	if moveDirection:
		# Move right if direction is positive, move left if negative
		velocity.x = moveDirection * SPEED
	else:
		 # Slow down if no input for smoother movement
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	  # Move the character based on the calculated velocity
	move_and_slide()
	AIMoveCalculation()
	
func _on_animated_sprite_2d_animation_finished():
	animated_sprite.play("idle_right")

@export var moveAcuracy : int = 10
func AIMoveCalculation():
	
	#highestPointOffset.emit()
	if(targetOffset + AIGridOffset) - transform.get_origin().x <= moveAcuracy && (targetOffset + AIGridOffset) - transform.get_origin().x >= -moveAcuracy :
		moveDirection = 0
	
	else:
		if (targetOffset + AIGridOffset) - transform.get_origin().x > 0:
			moveDirection = +1
		else:
			moveDirection = -1
		
		if velocity.x == 0:
			jump = true
		
	


func setoffset(offset):
	targetOffset = offset


func _on_area_2d_area_entered(area):
	if(area.name == "Damage_Area"):
		if not death_sound_player.playing:
			death_sound_player.play() # Play the death sound
		await get_tree().create_timer(0.4).timeout
		area.get_parent().queue_free()
		death.emit(area2D, player_id)
	pass # Replace with function body.

var dead : bool = false
func _on_area_2d_2_area_entered(area):
	if(area.name == "KillBox"):
		if not death_sound_player.playing:
			death_sound_player.play() # Play the death sound
		await get_tree().create_timer(0.4).timeout
		area.get_parent().queue_free()
		if !dead:
			dead = true
			death.emit(area2D, player_id)
	pass # Replace with function body.
