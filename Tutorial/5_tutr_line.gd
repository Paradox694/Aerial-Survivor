extends Sprite2D


func _on_next_pressed():
	get_tree().change_scene_to_file("res://Tutorial/6_tutr_water.tscn")


func _on_prev_pressed():
	get_tree().change_scene_to_file("res://Tutorial/4_tutr_death.tscn")



func _on_quit_pressed():
	get_tree().change_scene_to_file("res://MainMenu/MainMenu.tscn")
