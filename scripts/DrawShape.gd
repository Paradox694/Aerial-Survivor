extends Node2D

signal changeFBGArray(FBGArray: Array [int])

var shapeArray : Array[int] = ([1, 2, 3, 4, 5, 6, 7, 2, 4, 6, 5, 3, 7, 6, 3, 2, 6, 1, 7, 5, 4, 7, 6, 3, 7, 4, 2, 5, 1, 2, 7, 6, 1, 4, 5, 3, 1, 6, 7, 5, 2, 4])
var shapeArrayIndex: int = 0

@export var textureArray: Array [Texture2D]
var shapeToDraw: int = 1


var shape1 : Array [int] = [-1, -1, -1, -1, 2, 2, 2, 2, -1, -1, -1, -1, -1, -1, -1, -1]
var shape2 : Array [int] = [-1, -1, -1, -1, 3, 3, 3, -1, -1, -1, 3, -1, -1, -1, -1, -1]
var shape3 : Array [int] = [-1, -1, -1, -1, 4, 4, 4, -1, -1, 4, -1, -1, -1, -1, -1, -1]
var shape4 : Array [int] = [-1, -1, -1, -1, -1, 5, 5, 5, -1, 5, -1, -1, -1, -1, -1, -1]
var shape5 : Array [int] = [-1, -1, -1, -1, -1, 6, 6, -1, -1, 6, 6, -1, -1, -1, -1, -1]
var shape6 : Array [int] = [-1, -1, -1, -1, -1, 7, 7, -1, 7, 7, -1, -1, -1, -1, -1, -1]
var shape7 : Array [int] = [-1, -1, -1, -1, -1, 8, 8, -1, -1, -1, 8, 8, -1, -1, -1, -1]


func _draw():
	
	match shapeToDraw:
		1: # I-shape
			draw_texture(textureArray[0], Vector2 (28, 128))
			draw_texture(textureArray[0], Vector2 (60, 128))
			draw_texture(textureArray[0], Vector2 (92, 128))
			draw_texture(textureArray[0], Vector2 (124, 128))
		
		2: # L-shape
			draw_texture(textureArray[1], Vector2 (34, 128))
			draw_texture(textureArray[1], Vector2 (66, 128))
			draw_texture(textureArray[1], Vector2 (98, 128))
			draw_texture(textureArray[1], Vector2 (98, 96))
		
		3: # T-shape
			draw_texture(textureArray[2], Vector2 (66, 96))
			draw_texture(textureArray[2], Vector2 (66, 128))
			draw_texture(textureArray[2], Vector2 (98, 128))
			draw_texture(textureArray[2], Vector2 (34, 128))
			
		4: # J-shape
			draw_texture(textureArray[3], Vector2 (34, 96))
			draw_texture(textureArray[3], Vector2 (66, 128))
			draw_texture(textureArray[3], Vector2 (98, 128))
			draw_texture(textureArray[3], Vector2 (34, 128))
			
		5: # O-shape
			draw_texture(textureArray[4], Vector2 (50, 96))
			draw_texture(textureArray[4], Vector2 (82, 96))
			draw_texture(textureArray[4], Vector2 (82, 128))
			draw_texture(textureArray[4], Vector2 (50, 128))
			
		6: # Z-shape
			draw_texture(textureArray[5], Vector2 (34, 96))
			draw_texture(textureArray[5], Vector2 (66, 96))
			draw_texture(textureArray[5], Vector2 (66, 128))
			draw_texture(textureArray[5], Vector2 (98, 128))
			
		7: # S-Shape
			draw_texture(textureArray[6], Vector2 (34, 128))
			draw_texture(textureArray[6], Vector2 (66, 96))
			draw_texture(textureArray[6], Vector2 (66, 128))
			draw_texture(textureArray[6], Vector2 (98, 96))
			
			
func NextShape():
	match shapeToDraw:
		1: # I-shape
			changeFBGArray.emit(shape1)
			
		2: # L-shape
			changeFBGArray.emit(shape2)

		3: # T-shape
			changeFBGArray.emit(shape3)

		4: # J-shape
			changeFBGArray.emit(shape4)

		5: # O-shape
			changeFBGArray.emit(shape5)

		6: # Z-shape
			changeFBGArray.emit(shape6)

		7: # S-shape
			changeFBGArray.emit(shape7)
			
	shapeArrayIndex += 1
	if shapeArrayIndex >= shapeArray.size():
		shapeArrayIndex = 0
		
	# shapeArrayIndex = randi_range(0, shapeArray.size() - 1)
	shapeToDraw = shapeArray[shapeArrayIndex]
	queue_redraw()

# Called when the node enters the scene tree for the first time.
func _ready():
	shapeArrayIndex = randi_range(0, shapeArray.size() - 1)
	shapeToDraw = shapeArray[shapeArrayIndex]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
