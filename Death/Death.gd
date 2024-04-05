extends Node2D

signal death

signal player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function bodysignals
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#death.emit()
	pass

func Die(area, player_id):
	area.get_parent().queue_free()
	get_tree().change_scene_to_file("res://Defeat Screen/Defeat_screen.tscn")

func MultiplayerDie(area, player_id):
	area.get_parent().queue_free()
	if player_id == 1:
		get_tree().change_scene_to_file("res://Multiplayer/player_2_wins.tscn")
	
	else:
		get_tree().change_scene_to_file("res://Multiplayer/player_1_wins.tscn")
