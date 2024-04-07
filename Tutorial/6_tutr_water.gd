extends Sprite2D


func _on_next_pressed():
	get_tree().change_scene_to_file("res://Tutorial/7_tutr_end.tscn")


func _on_prev_pressed():
	get_tree().change_scene_to_file("res://Tutorial/5_tutr_line.tscn")


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://MainMenu/MainMenu.tscn")
