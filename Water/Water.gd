extends AnimatableBody2D

signal stop

signal fillRow(fillType, row)

@onready var polygon_2d = $Polygon2D

# Called when the node enters the scene tree for the first time.
func _ready():
	print(polygon_2d.position.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(polygon_2d.position.y < -540):
		emit_signal("stop")

func _on_water_timer_rise():
	# original way of moving the water
	#polygon_2d.position.y = polygon_2d.position.y - 0.5
	
	var fillType = 1
	
	var row = 0
	
	fillRow.emit(fillType, row)
	
	print("The water is rising")
