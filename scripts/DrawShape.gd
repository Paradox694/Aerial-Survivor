extends Node2D

signal changeFBGArray(FBGArray: Array [int])

@export var textureArray: Array [Texture2D]
var shapeToDraw: int = 1
var column: int
var row: int

var shape1 : Array [int] = [0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0]
var shape2 : Array [int] = [0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 2, 0, 0, 0, 0, 0]

func _draw():
	
	match shapeToDraw:
		1: # "Line" shape
			draw_texture(textureArray[0], Vector2 (40, 112))
			draw_texture(textureArray[0], Vector2 (72, 112))
			draw_texture(textureArray[0], Vector2 (104, 112))
			draw_texture(textureArray[0], Vector2 (136, 112))
		
		2: # Right "L" shape
			draw_texture(textureArray[1], Vector2 (48, 112))
			draw_texture(textureArray[1], Vector2 (80, 112))
			draw_texture(textureArray[1], Vector2 (112, 112))
			draw_texture(textureArray[1], Vector2 (112, 80))
		
		3: # "T" shape
			draw_texture(textureArray[2], Vector2 (80, 80))
			draw_texture(textureArray[2], Vector2 (80, 112))
			draw_texture(textureArray[2], Vector2 (112, 112))
			draw_texture(textureArray[2], Vector2 (48, 112))
			
		4: # Left "L" shape
			draw_texture(textureArray[3], Vector2 (48, 80))
			draw_texture(textureArray[3], Vector2 (80, 112))
			draw_texture(textureArray[3], Vector2 (112, 112))
			draw_texture(textureArray[3], Vector2 (48, 112))
			
		5: # Box shape
			draw_texture(textureArray[4], Vector2 (64, 80))
			draw_texture(textureArray[4], Vector2 (96, 80))
			draw_texture(textureArray[4], Vector2 (96, 112))
			draw_texture(textureArray[4], Vector2 (64, 112))
			
		6: # Left "S" shape
			draw_texture(textureArray[5], Vector2 (48, 80))
			draw_texture(textureArray[5], Vector2 (80, 80))
			draw_texture(textureArray[5], Vector2 (80, 112))
			draw_texture(textureArray[5], Vector2 (112, 112))
			
		7: # Right "S" Shape
			draw_texture(textureArray[6], Vector2 (48, 112))
			draw_texture(textureArray[6], Vector2 (80, 80))
			draw_texture(textureArray[6], Vector2 (80, 112))
			draw_texture(textureArray[6], Vector2 (112, 80))
			
			
func NextShape():
	match shapeToDraw:
		1: 
			changeFBGArray.emit(shape1)
			shapeToDraw = 2
		2:
			changeFBGArray.emit(shape2)
			shapeToDraw = 1
	queue_redraw()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
