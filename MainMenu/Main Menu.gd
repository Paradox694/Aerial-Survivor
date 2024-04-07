extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://MainMenu/PlayMenu.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://MainMenu/OptionsMainMenu.tscn")
	
func _on_quit_pressed():
	get_tree().quit()

func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://Tutorial/1_tutr_begin.tscn")
