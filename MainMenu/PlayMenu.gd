extends Control

func _on_practice_button_pressed():
	get_tree().change_scene_to_file("res://Grid/GridTest.tscn")

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://MainMenu/MainMenu.tscn")


func _on_single_p_button_pressed():
	get_tree().change_scene_to_file("res://AI/single_player_level.tscn")


func _on_multi_p_button_pressed():
	get_tree().change_scene_to_file("res://Multiplayer/Multiplayer_test.tscn")

