extends AnimatableBody2D

signal stop

@onready var polygon_2d = $Polygon2D

# Called when the node enters the scene tree for the first time.
func _ready():
	print(polygon_2d.position.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(polygon_2d.position.y < -540):
		emit_signal("stop")

func _on_water_timer_rise():
	polygon_2d.position.y = polygon_2d.position.y - 0.5
	print("The water is rising")
	print(polygon_2d.position.y)
