extends Node2D

signal stop

@onready var collision_shape_2d = $Damage_Area

# Called when the node enters the scene tree for the first time.
func _ready():
	print(collision_shape_2d.position.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(collision_shape_2d.position.y < -600):
		print(collision_shape_2d.position.y)
		emit_signal("stop")

func _on_water_timer_rise():
	print(collision_shape_2d.position.y)
	collision_shape_2d.position.y = collision_shape_2d.position.y - 0.5
