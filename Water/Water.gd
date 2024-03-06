extends AnimatableBody2D

signal stop

signal fillRow(fillType, row)

@onready var polygon_2d = $Polygon2D

@export var maxWaterHight : int = 19

var fillType = 1
	
var row = 0
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#print(polygon_2d.position.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	# original way of moving the water
	#if(polygon_2d.position.y < -540):
		#emit_signal("stop")
	
	#if(timer.time_left == 1.0):
		#row += 1
	
	#if(row == maxWaterHight - 1):
		#emit_signal("stop")

func WaterRise(Levels : int):
	# original way of moving the water
	#polygon_2d.position.y = polygon_2d.position.y - 0.5
	
	for r in range(Levels):
		row += 1
		
		if(row >=maxWaterHight):
			stop.emit()
			break
		
		fillRow.emit(fillType, row)
		print("The water is rising")
