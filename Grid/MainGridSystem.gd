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


#array to hold the Falling block grid
var FallingBlockGrid : Array[String]
#varibles that control the size of the falling block grid
var FBGColSize = 4
var FBGRowSize = 4
#extra varibles for the fallingBlockGrid
@export var FBGReferenceLocation : Vector2i 


func _init():
	#setting the main grid to correct size and filling it
	MainGrid.resize(MGColSize*MGRowSize)
	MainGrid.fill("empty")
	
	#setting the falling grid to correct size and filling it
	FallingBlockGrid.resize(FBGColSize*FBGRowSize)
	FallingBlockGrid.fill("empty")
	

	
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
#function that fill in a whole row with specified data
func MainGridRowFill(fillType: String, row: int):
	if row > 0 and row < MGRowSize:
		for c in range(MGColSize):
			MainGrid[(row * MGColSize) + c] = fillType


#function to imulate setting a value in a 2D array
func FBGWrite(data: String, col: int, row: int):
	MainGrid[(row*MGColSize)+col] = data
#function to imulate reading a value in a 2D array
func FBGRead(col: int, row: int):
	return MainGrid[(row*MGColSize) + col]
#function to rotate falling block grid clockwise
func FBGRotateRight():
	#creating and filling store new data location inbetween transition
	@warning_ignore("unassigned_variable")
	var temp : Array[String]
	temp.resize(FBGColSize*FBGRowSize)
	temp.fill("empty")
	
	#coping varibles over to new grid
	for r in range(FBGRowSize):
		for c in range(FBGColSize):
			temp[(FBGColSize * (FBGRowSize - c - 1) ) + r] = FBGRead(c, r)
	
	#setting the grid to the new locations
	FallingBlockGrid = temp
	
	#check for blocks out of bounds and move the FBGrid to solve
	checkFBGridOutOfBounds()

#cheacks to see if any FBGrid blocks are out of bounds. if there are it moves the FBGrid to solve the issue
func checkFBGridOutOfBounds():
	
	#checks if any colums are out of bound on left side
	if( FBGReferenceLocation.x < 0):
		#finds how many cols are out of bounds and cheacks to see if any blocks are out side
		var colOutOfBounds = FBGReferenceLocation.x * -1
		for c in range(colOutOfBounds):
			for r in range(FBGRowSize):
				#if a block is found to be outside move the referance point over to garenty its not
				if(FBGRead(c,r) != "empty"):
					FBGReferenceLocation.x += colOutOfBounds
	
	#checks if any coms are out of bounds on the right side
	if(FBGReferenceLocation.x + FBGColSize - 1 >= MGColSize):
		#finds how many cols are out of bounds and cheacks to see if any blocks are out side
		var colOutOfBounds = FBGReferenceLocation.x + FBGColSize - MGColSize + 1
		for c in range(FBGColSize -1, colOutOfBounds -1, -1):
			for r in range(FBGRowSize):
				#if a block is found to be outside move the referance point over to garenty its not
				if(FBGRead(c,r) != "empty"):
					FBGReferenceLocation.x -= colOutOfBounds
		
		



