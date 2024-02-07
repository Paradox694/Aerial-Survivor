extends Shape0
class_name Shape4

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation_matrix = [
	[Vector2(80,0),Vector2(0,0),Vector2(-80,0),Vector2(-80,-80)],
	[Vector2(0,80),Vector2(0,0),Vector2(0,-80),Vector2(80,-80)],
	[Vector2(-80,0),Vector2(0,0),Vector2(80,0),Vector2(80,80)],
	[Vector2(0,-80),Vector2(0,0),Vector2(0,80),Vector2(-80,80)]
	]
	draw_shape()
	rotate_position = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
