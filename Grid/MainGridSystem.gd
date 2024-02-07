extends Node2D



#array of all the textures
@export var cloudTextures : Array[Texture2D]
#varibles for rendering
@export var rowRenderOffset : float
@export var colRenderOffset : float




#arrya to be used as the main grid 
var MainGrid : Array[int]
#varibles that control the size of the main grid
var MGColSize = 10
var MGRowSize = 20


#array to hold the Falling block grid
var FallingBlockGrid : Array[int]
#varibles that control the size of the falling block grid
var FBGColSize = 4
var FBGRowSize = 4
#extra varibles for the fallingBlockGrid
@export var FBGReferenceLocation : Vector2i 


func _init():
	#setting the main grid to correct size and filling it
	MainGrid.resize(MGColSize*MGRowSize)
	MainGrid.fill(0)
	
	#setting the falling grid to correct size and filling it
	FallingBlockGrid.resize(FBGColSize*FBGRowSize)
	FallingBlockGrid.fill(0)
	FBGReferenceLocation = Vector2i(3,2)
	
	#use in testing
	MainGridWrite(1,0,0)	
	MainGridWrite(5,1,0)
	MainGridWrite(1,2,0)
	MainGridWrite(1,3,0)
	MainGridWrite(1,4,0)
	MainGridWrite(1,5,0)
	MainGridWrite(1,6,0)
	MainGridWrite(1,7,0)
	MainGridWrite(1,8,0)
	MainGridWrite(1,9,0)
	
	
	FBGWrite(6,1,0)
	FBGWrite(6,2,0)
	FBGWrite(6,1,1)
	FBGWrite(6,1,2)
	FBGWrite(7,0,0)
	

func _input(event):
	if event.is_action_pressed("RotateBlockRight"):
		FBGRotateRight()
	
	if event.is_action_pressed("RotateBlockLeft"):
		FBGRotateLeft()
	
	if event.is_action_pressed("MoveBlockRight"):
		FBGReferenceLocation.x += 1
		checkFBGridOutOfBounds()
		
	if event.is_action_pressed("MoveBlockLeft"):
		FBGReferenceLocation.x -= 1
		checkFBGridOutOfBounds()
	


func _process(delta):
	


	
#draws all the clouds in the grid
func _draw():
	#draws the main grid
	for r in range(MGRowSize):
		for c in range(MGColSize):
			if(MainGridRead(c,r) != 0):
				draw_texture(cloudTextures[MainGridRead(c,r)],Vector2(c * colRenderOffset, r * -rowRenderOffset))
		
	#draw falling block grid
	for r in range(FBGRowSize):
		for c in range(FBGColSize):
			if(FBGRead(c,r) != 0):
				draw_texture(cloudTextures[FBGRead(c,r)],Vector2((c+ FBGReferenceLocation.x) * colRenderOffset , (r + FBGReferenceLocation.y) * -rowRenderOffset))
		

func updateTextures():
	queue_redraw()


#function to imulate setting a value in a 2D array
func MainGridWrite(data: int, col: int, row: int):
	MainGrid[(row*MGColSize)+col] = data
#function to imulate reading a value in a 2D array
func MainGridRead(col: int, row: int):
	return MainGrid[(row*MGColSize) + col]
#function that fill in a whole row with specified data
func MainGridRowFill(fillType: int, row: int):
	if row > 0 and row < MGRowSize:
		for c in range(MGColSize):
			MainGrid[(row * MGColSize) + c] = fillType


#function to imulate setting a value in a 2D array
func FBGWrite(data: int, col: int, row: int):
	FallingBlockGrid[(row*FBGColSize)+col] = data
#function to imulate reading a value in a 2D array
func FBGRead(col: int, row: int):
	return FallingBlockGrid[(row*FBGColSize) + col]
#function to rotate falling block grid clockwise
func FBGRotateRight():
	#creating and filling store new data location inbetween transition
	@warning_ignore("unassigned_variable")
	var temp : Array[int]
	temp.resize(FBGColSize*FBGRowSize)
	temp.fill(0)
	
	#coping varibles over to new grid
	for r in range(FBGRowSize):
		for c in range(FBGColSize):
			temp[(FBGColSize * (FBGRowSize - c - 1) ) + r] = FBGRead(c, r)
	
	#setting the grid to the new locations
	FallingBlockGrid = temp
	
	#check for blocks out of bounds and move the FBGrid to solve
	checkFBGridOutOfBounds()
	
	
	

func FBGRotateLeft():
	#creating and filling store new data location inbetween transition
	@warning_ignore("unassigned_variable")
	var temp : Array[int]
	temp.resize(FBGColSize*FBGRowSize)
	temp.fill(0)
	
	#coping varibles over to new grid
	for r in range(FBGRowSize):
		for c in range(FBGColSize):
			temp[(FBGColSize * c ) + (FBGRowSize - r - 1)] = FBGRead(c, r)
	
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
		
	queue_redraw()



