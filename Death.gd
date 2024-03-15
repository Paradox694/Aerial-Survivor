extends Node2D

signal death

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function bodysignals
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	death.emit()
	pass

func die():
	queue_free()
