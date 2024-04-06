extends Sprite2D


func _on_next_pressed():
	get_tree().change_scene_to_file("res://Tutorial/3_tutr_rotate.tscn")


func _on_prev_pressed():
	get_tree().change_scene_to_file("res://Tutorial/1_tutr_begin.tscn")

