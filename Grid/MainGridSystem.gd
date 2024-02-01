extends Node2D

#array of all the textures
@export var cloudTextures : Texture2DArray
#varibles for rendering
@export var rowRenderOffset : float
@export var colRenderOffset : float




#arrya to be used as the main grid 
var MainGrid : Array[String]
#varibles that control the size of the main grid
var MGColSize = 10
var MGRowSize = 20





func _init():
	MainGrid.resize(MGColSize*MGRowSize)
	MainGrid.fill(0)
	
#draws all the clouds in the grid
func _draw():
	for r in range(MGRowSize):
		for c in range(MGColSize):
			draw_texture(cloudTextures[MainGridRead(c,r)],Vector2(c * colRenderOffset, r * rowRenderOffset))
		

func updateTextures():
	queue_redraw()


#function to imulate setting a value in a 2D array
func MainGridWrite(data: String, col: int, row: int):
	MainGrid[(row*MGColSize)+col] = data
#function to imulate reading a value in a 2D array
func MainGridRead(col: int, row: int):
	return MainGrid[(row*MGColSize) + col]
func MainGridRowFill(fillType: String, row: int):
	if row > 0 and row < MGRowSize:
		for c in range(MGColSize):
			MainGrid[(row * MGColSize) + c] = fillType



