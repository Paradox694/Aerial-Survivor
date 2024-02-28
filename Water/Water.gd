extends AnimatableBody2D

signal stop

signal fill

@onready var polygon_2d = $Polygon2D

# part of the first attempt
#const gridSystem := preload("res://Grid/MainGridSystem.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	print(polygon_2d.position.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(polygon_2d.position.y < -540):
		emit_signal("stop")

func _on_water_timer_rise():
	# original way of moving the water
	# polygon_2d.position.y = polygon_2d.position.y - 0.5
	
	# first attempt at moving the water via preloading
	# var instance = gridSystem.new()
	# instance.MainGridRowFill(0,1)
	
	# second attempt
	var p = get_node("Node2D/MainGrid")
	p.MainGridRowFill(0,1)
	
	print("The water is rising")
	print(polygon_2d.position.y)
