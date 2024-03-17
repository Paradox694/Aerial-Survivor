extends Node2D

signal changeFBGArray(FBGArray: Array [int])

@export var textureArray: Array [Texture2D]
var shapeToDraw: int = 1
var column: int
var row: int

var shape1 : Array [int] = [-1, -1, -1, -1, 2, 2, 2, 2, -1, -1, -1, -1, -1, -1, -1, -1]
var shape2 : Array [int] = [-1, -1, -1, -1, 3, 3, 3, -1, -1, -1, 3, -1, -1, -1, -1, -1]
var shape4 : Array [int] = [-1, -1, -1, -1, -1, 5, 5, 5, -1, 5, -1, -1, -1, -1, -1, -1]
var shape5 : Array [int] = [-1, -1, -1, -1, -1, 6, 6, -1, -1, 6, 6, -1, -1, -1, -1, -1]
var shape3 : Array [int] = [-1, -1, -1, -1, 4, 4, 4, -1, -1, 4, -1, -1, -1, -1, -1, -1]
var shape6 : Array [int] = [-1, -1, -1, -1, -1, 7, 7, -1, 7, 7, -1, -1, -1, -1, -1, -1]
var shape7 : Array [int] = [-1, -1, -1, -1, -1, 8, 8, -1, -1, -1, 8, 8, -1, -1, -1, -1]

func _draw():
	
	match shapeToDraw:
		1: # I-shape
			draw_texture(textureArray[0], Vector2 (40, 112))
			draw_texture(textureArray[0], Vector2 (72, 112))
			draw_texture(textureArray[0], Vector2 (104, 112))
			draw_texture(textureArray[0], Vector2 (136, 112))
		
		2: # L-shape
			draw_texture(textureArray[1], Vector2 (48, 112))
			draw_texture(textureArray[1], Vector2 (80, 112))
			draw_texture(textureArray[1], Vector2 (112, 112))
			draw_texture(textureArray[1], Vector2 (112, 80))
		
		3: # T-shape
			draw_texture(textureArray[2], Vector2 (80, 80))
			draw_texture(textureArray[2], Vector2 (80, 112))
			draw_texture(textureArray[2], Vector2 (112, 112))
			draw_texture(textureArray[2], Vector2 (48, 112))
			
		4: # J-shape
			draw_texture(textureArray[3], Vector2 (48, 80))
			draw_texture(textureArray[3], Vector2 (80, 112))
			draw_texture(textureArray[3], Vector2 (112, 112))
			draw_texture(textureArray[3], Vector2 (48, 112))
			
		5: # O-shape
			draw_texture(textureArray[4], Vector2 (64, 80))
			draw_texture(textureArray[4], Vector2 (96, 80))
			draw_texture(textureArray[4], Vector2 (96, 112))
			draw_texture(textureArray[4], Vector2 (64, 112))
			
		6: # Z-shape
			draw_texture(textureArray[5], Vector2 (48, 80))
			draw_texture(textureArray[5], Vector2 (80, 80))
			draw_texture(textureArray[5], Vector2 (80, 112))
			draw_texture(textureArray[5], Vector2 (112, 112))
			
		7: # S-Shape
			draw_texture(textureArray[6], Vector2 (48, 112))
			draw_texture(textureArray[6], Vector2 (80, 80))
			draw_texture(textureArray[6], Vector2 (80, 112))
			draw_texture(textureArray[6], Vector2 (112, 80))
			
			
func NextShape():
	match shapeToDraw:
		1: # I-shape
			changeFBGArray.emit(shape1)
			shapeToDraw = 2
		2: # L-shape
			changeFBGArray.emit(shape2)
			shapeToDraw = 3
		3: # T-shape
			changeFBGArray.emit(shape3)
			shapeToDraw = 4
		4: # J-shape
			changeFBGArray.emit(shape4)
			shapeToDraw = 5
		5: # O-shape
			changeFBGArray.emit(shape5)
			shapeToDraw = 6
		6: # Z-shape
			changeFBGArray.emit(shape6)
			shapeToDraw = 7
		7: # S-shape
			changeFBGArray.emit(shape7)
			shapeToDraw = 1
	queue_redraw()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
