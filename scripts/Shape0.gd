extends Node2D
class_name Shape0


var rotate_position = 0
var is_fixed = false

var rotation_matrix = []
var create_position: Vector2 = Vector2.ZERO

func draw_shape():
	var ind = 0
	for ch in get_children():
		ch.position = rotation_matrix[rotate_position][ind]
		ind += 1

func inactivate_it():
	if position == create_position:
		get_tree().reload_current_scene()
	for ch in get_children():
		ch.inactivate_it()
