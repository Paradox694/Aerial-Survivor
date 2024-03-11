extends Node2D

#pause menu
@onready var pause_menu = $PauseMenu
var paused = false

#open pause menu
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

func pauseMenu():
	if paused: 
		pause_menu.hide()
	else:
		pause_menu.show()
	
	paused = !paused
