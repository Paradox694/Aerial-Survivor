extends Node2D



#array of all the textures
@export var cloudTextures : Array[Texture2D]
#varibles for rendering
@export var rowRenderOffset : float
@export var colRenderOffset : float


#varibles for block falling automaticly
@export var blockFallingRate : float
var blockFallingTimer
@export var FBGResetPosition : Vector2i

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
var FBGReferenceLocation : Vector2i 


func _init():
	#setting the main grid to correct size and filling it
	MainGrid.resize(MGColSize*MGRowSize)
	MainGrid.fill(0)
	
	#setting the falling grid to correct size and filling it
	FallingBlockGrid.resize(FBGColSize*FBGRowSize)
	FallingBlockGrid.fill(0)
	FBGReferenceLocation = Vector2i(3,15)
	#code for testing
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
		if checkForMoveCollison(1):
			FBGReferenceLocation.x += 1
			checkFBGridOutOfBounds()
		
	if event.is_action_pressed("MoveBlockLeft"):
		if checkForMoveCollison(-1):
			FBGReferenceLocation.x -= 1
			checkFBGridOutOfBounds()
	


	
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
	if checkForRotationCollison(temp):
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
	if checkForRotationCollison(temp):
		FallingBlockGrid = temp
	
	#check for blocks out of bounds and move the FBGrid to solve
	checkFBGridOutOfBounds()
	
	

func checkForRotationCollison(NewRoation : Array[int]):
	for r in range(FBGRowSize):
		for c in range(FBGColSize):
			if(MainGridRead(c + FBGReferenceLocation.x, r + FBGReferenceLocation.y) != 0 and NewRoation[(r * FBGColSize) + c] != 0):
				return false
	return true
	
func checkForMoveCollison(MoveDelta : int):
	for r in range(FBGRowSize):
		for c in range(FBGColSize):
			if(MainGridRead(c + FBGReferenceLocation.x + MoveDelta, r + FBGReferenceLocation.y) != 0 and FallingBlockGrid[(r * FBGColSize) + c] != 0):
				return false
	return true

#cheacks to see if any FBGrid blocks are out of bounds. if there are it moves the FBGrid to solve the issue
func checkFBGridOutOfBounds():
	
	#checks if any colums are out of bound on left side
	if( FBGReferenceLocation.x < 0):
		#finds how many cols are out of bounds and cheacks to see if any blocks are out side
		var colOutOfBounds = FBGReferenceLocation.x * -1
		for c in range(colOutOfBounds):
			for r in range(FBGRowSize):
				#if a block is found to be outside move the referance point over to garenty its not
				if(FBGRead(c,r) != 0):
					FBGReferenceLocation.x += 1
					break
	
	#checks if any coms are out of bounds on the right side
	if(FBGReferenceLocation.x + FBGColSize - 1 >= MGColSize):
		#finds how many cols are out of bounds and cheacks to see if any blocks are out side
		var colOutOfBounds = FBGReferenceLocation.x + FBGColSize - MGColSize 
		for c in range(-1, -colOutOfBounds -1, -1):
			for r in range(FBGRowSize):
				#if a block is found to be outside move the referance point over to garenty its not
				if(FBGRead(c,r) != 0):
					FBGReferenceLocation.x -= 1
					break
					
		
	queue_redraw()


func FBGBlockFall():
	if(FBGReferenceLocation.y == 0):
		FBGReset()
		return
	
	for r in range(FBGRowSize):
		for c in range(FBGColSize):
			if(MainGridRead(c + FBGReferenceLocation.x, r + FBGReferenceLocation.y - 1) != 0 and FBGRead(c,r) != 0):
				FBGReset()
				return
			
	FBGReferenceLocation.y -= 1
	queue_redraw()

func FBGReset():
	for r in range(FBGRowSize):
		for c in range(FBGColSize):
			if(FBGRead(c,r) != 0):
				MainGridWrite(FBGRead(c,r), c + FBGReferenceLocation.x, r + FBGReferenceLocation.y)
	FBGReferenceLocation = FBGResetPosition

func _on_grid_block_fall_timer_timeout():
	FBGBlockFall()
