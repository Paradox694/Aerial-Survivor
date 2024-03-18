extends Node2D

signal changeFBGArray(FBGArray: Array [int])

@export var shapeArray: Array [int]
var shapeArrayIndex: int = 0

@export var textureArray: Array [Texture2D]
var shapeToDraw: int = 1


var shape1: Array [int] = [0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0]
var shape2: Array [int] = [0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 2, 0, 0, 0, 0, 0]
var shape3: Array [int] = [0, 0, 0, 0, 3, 3, 3, 0, 0, 3, 0, 0, 0, 0, 0, 0]
var shape4: Array [int] = [0, 0, 0, 0, 0, 4, 4, 4, 0, 4, 0, 0, 0, 0, 0, 0]
var shape5: Array [int] = [0, 0, 0, 0, 0, 5, 5, 0, 0, 5, 5, 0, 0, 0, 0, 0]
var shape6: Array [int] = [0, 0, 0, 0, 0, 6, 6, 0, 6, 6, 0, 0, 0, 0, 0, 0]
var shape7: Array [int] = [0, 0, 0, 0, 0, 7, 7, 0, 0, 0, 7, 7, 0, 0, 0, 0]

func _draw():
	
	match shapeToDraw:
		1: # I-shape
			draw_texture(textureArray[0], Vector2 (44, 128))
			draw_texture(textureArray[0], Vector2 (76, 128))
			draw_texture(textureArray[0], Vector2 (108, 128))
			draw_texture(textureArray[0], Vector2 (140, 128))
		
		2: # L-shape
			draw_texture(textureArray[1], Vector2 (60, 128))
			draw_texture(textureArray[1], Vector2 (92, 128))
			draw_texture(textureArray[1], Vector2 (124, 128))
			draw_texture(textureArray[1], Vector2 (124, 96))
		
		3: # T-shape
			draw_texture(textureArray[2], Vector2 (92, 96))
			draw_texture(textureArray[2], Vector2 (92, 128))
			draw_texture(textureArray[2], Vector2 (124, 128))
			draw_texture(textureArray[2], Vector2 (60, 128))
			
		4: # J-shape
			draw_texture(textureArray[3], Vector2 (60, 96))
			draw_texture(textureArray[3], Vector2 (92, 128))
			draw_texture(textureArray[3], Vector2 (124, 128))
			draw_texture(textureArray[3], Vector2 (60, 128))
			
		5: # O-shape
			draw_texture(textureArray[4], Vector2 (76, 96))
			draw_texture(textureArray[4], Vector2 (108, 96))
			draw_texture(textureArray[4], Vector2 (108, 128))
			draw_texture(textureArray[4], Vector2 (76, 128))
			
		6: # Z-shape
			draw_texture(textureArray[5], Vector2 (60, 96))
			draw_texture(textureArray[5], Vector2 (92, 96))
			draw_texture(textureArray[5], Vector2 (92, 128))
			draw_texture(textureArray[5], Vector2 (124, 128))
			
		7: # S-Shape
			draw_texture(textureArray[6], Vector2 (60, 128))
			draw_texture(textureArray[6], Vector2 (92, 96))
			draw_texture(textureArray[6], Vector2 (92, 128))
			draw_texture(textureArray[6], Vector2 (124, 96))
			
			
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
