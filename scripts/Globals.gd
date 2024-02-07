extends Node2D

# signals for inactivated shapes and points
signal inact_shape

# varibales for position, inactvated blocks
var inactive = []
var inactive_blocks = []
var speed = 1

# send out signal
func inactivate_shape():
	emit_signal("inact_shape")

func restart_game():
	speed = 1
	inactive.clear()
	inactive_blocks.clear()
	get_tree().reload_current_scene()
