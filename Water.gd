extends AnimatableBody2D

@onready var polygon_2d = $Polygon2D
@onready var collision_polygon_2d = $CollisionPolygon2D

# Called when the node enters the scene tree for the first time.
func _ready():
	collision_polygon_2d.polygon = polygon_2d.polygon


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_water_timer_rise():
	polygon_2d.position.y = polygon_2d.position.y - 1
	print("The water is rising")
