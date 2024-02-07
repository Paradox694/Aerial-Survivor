extends Node2D


var is_active = false

# Connect to the Global script to receive inact_shape signal, 
# if signal occurs then call inactivate_it func
func _ready():
	is_active = true
	# Globals.connect("inact_shape", self, "inactivate_it")

func inactivate_it():
	if is_active:
		# fix parent shape and set active to false
		get_parent().is_fixed = true
		is_active = false
		# active_block used to check if it shoud respawn a new shape(false = no blocks active)
		get_tree().root.get_node("Main").active_block = false
		# add inactive block position and call the inactivate_shape to activate full shape
		Globals.inactive.append(get_parent().position + position)
		Globals.inactive_blocks.append(self)
		Globals.inactivate_shape()

# chekc if can rotate
func can_rotate(val) -> bool:
	if Globals.inactive.has(Vector2(get_parent().position.x + val.x, get_parent().position.y + val.y)) or is_off_screen(Vector2(get_parent().position.x + val.x, get_parent().position.y + val.y)):
		return false
	else:
		return true

# check if a block is outside the screen
func is_off_screen(vec) -> bool:
	if vec.x < 0:
		return true
	elif vec.x >= get_parent().get_parent().get_rect().size.x:
		return true
	elif vec.y < 0:
		return true
	elif vec.y >= get_parent().get_parent().get_rect().size.y:
		return true
	else:
		return false

# check to see if there is a block in the way then moves
func can_move_down():
	if Globals.inactive.has(Vector2(get_parent().position.x + position.x, get_parent().position.y + position.y + 80)) or get_parent().position.y + position.y == 1520:
		inactivate_it()
		return false
	else:
		return true

func can_move_left():
	if get_parent().position.x + position.x == 0 or (Globals.inactive.has(Vector2(get_parent().position.x + position.x - 80, get_parent().position.y + position.y))) or not is_active:
		return false
	else:
		return true

func can_move_right():
	if get_parent().position.x + position.x == 720 or (Globals.inactive.has(Vector2(get_parent().position.x + position.x + 80, get_parent().position.y + position.y))) or not is_active:
		return false
	else:
		return true
