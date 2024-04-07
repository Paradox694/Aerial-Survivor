extends Sprite2D


func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://Tutorial/2_tutr_player.tscn")


func _on_quit_pressed():
		get_tree().change_scene_to_file("res://MainMenu/MainMenu.tscn")

