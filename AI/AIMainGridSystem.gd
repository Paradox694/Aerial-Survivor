extends Node2D



#array of all the textures
@export var cloudTextures : Array[Texture2D]
#varibles for rendering
@export var rowRenderOffset : float
@export var colRenderOffset : float

signal SendWater(WaterSent :int)
#varibles for block falling automaticly

var blockFallingTimer
@export var FBGResetPosition : Vector2i
signal FBGResetArray()

#arrya to be used as the main grid 
var MainGrid : Array[int]
#varibles that control the size of the main grid
var MGColSize = 10
var MGRowSize = 20
var MGoverFlow = 60

#array to hold the Falling block grid
var FallingBlockGrid : Array[int]
#varibles that control the size of the falling block grid
var FBGColSize = 4
var FBGRowSize = 4
#extra varibles for the fallingBlockGrid
var FBGReferenceLocation : Vector2i 
var FBGDropReset : bool = false

#collider
var collider = preload("res://Grid/block_collider.tscn")
var collisionGrid : Array

#varibles to stop blocks afterhitting limit
var RoofHit : bool = false;
signal StopBlockFallTimer()

#saves dirrections after calculation
var targetOffset : int = 0
var targetRotaion : int = 0


func _init():
	#setting the main grid to correct size and filling it
	MainGrid.resize(MGColSize*MGRowSize+MGoverFlow)
	MainGrid.fill(-1)
	
	#setting the falling grid to correct size and filling it
	FallingBlockGrid.resize(FBGColSize*FBGRowSize)
	FallingBlockGrid.fill(-1)
	FBGReferenceLocation = Vector2i(3,20)

	collisionGrid.resize(MainGrid.size())

func _ready():
	#gets first block
	FBGResetArray.emit()
	


func _input(_event):
	pass
	#if event.is_action_pressed("RotateBlockRight"):
		#FBGRotateRight()
	#
	#if event.is_action_pressed("RotateBlockLeft"):
		#FBGRotateLeft()
	#
	#if event.is_action_pressed("MoveBlockRight"):
		#if checkForMoveCollison(1):
			#FBGReferenceLocation.x += 1
			#checkFBGridOutOfBounds()
		#
	#if event.is_action_pressed("MoveBlockLeft"):
		#if checkForMoveCollison(-1):
			#FBGReferenceLocation.x -= 1
			#checkFBGridOutOfBounds()
	

func _physics_process(_delta):
	pass
	#if(Input.is_action_just_pressed("DropBlock")):
		#FBGDropReset = false
	#
	#if(!FBGDropReset):
		#if(Input.is_action_pressed("DropBlock") && !RoofHit):
			#FBGBlockFall()

	
#draws all the clouds in the grid
func _draw():
	#draws the main grid
	for r in range(MGRowSize, -1, -1):
		for c in range(MGColSize):
			if(MainGridRead(c,r) > -1):
				if(MainGridRead(c,r) != 1):
					draw_texture(cloudTextures[MainGridRead(c,r)],Vector2(c * colRenderOffset, r * -rowRenderOffset))
				if(MainGridRead(c,r) == 1):
					draw_texture(cloudTextures[MainGridRead(c,r)],Vector2(c * colRenderOffset, r * -rowRenderOffset - 4))
					
		
	#draw falling block grid
	for r in range(FBGRowSize):
		for c in range(FBGColSize):
			if(FBGRead(c,r) > -1):
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
	if row >= 0 and row < MGRowSize:
		for c in range(MGColSize):
			MainGrid[(row * MGColSize) + c] = fillType
		blockDropAICalCulation()


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
	temp.fill(-1)
	
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
	temp.fill(-1)
	
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
			if(MainGridRead(c + FBGReferenceLocation.x, r + FBGReferenceLocation.y) > -1 and NewRoation[(r * FBGColSize) + c] > -1):
				return false
	return true
	
func checkForMoveCollison(MoveDelta : int):
	for r in range(FBGRowSize):
		for c in range(FBGColSize):
			if(MainGridRead(c + FBGReferenceLocation.x + MoveDelta, r + FBGReferenceLocation.y) > -1 and FallingBlockGrid[(r * FBGColSize) + c] > -1):
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
				if(FBGRead(c,r) > -1):
					FBGReferenceLocation.x += 1
					break
	
	#checks if any coms are out of bounds on the right side
	if(FBGReferenceLocation.x + FBGColSize - 1 >= MGColSize):
		#finds how many cols are out of bounds and cheacks to see if any blocks are out side
		var colOutOfBounds = FBGReferenceLocation.x + FBGColSize - MGColSize 
		for c in range(-1, -colOutOfBounds -1, -1):
			for r in range(FBGRowSize):
				#if a block is found to be outside move the referance point over to garenty its not
				if(FBGRead(c,r) > -1):
					FBGReferenceLocation.x -= 1
					break
					
		
	queue_redraw()


func FBGBlockFall():
	
	
	for r in range(FBGRowSize):
		for c in range(FBGColSize):
			if((r + FBGReferenceLocation.y) == 0 and FBGRead(c,r) > -1):
				FBGReset()
				return
			if(MainGridRead(c + FBGReferenceLocation.x, r + FBGReferenceLocation.y - 1) > -1 and FBGRead(c,r) > -1):
				FBGReset()
				return
			
			
	FBGReferenceLocation.y -= 1
	queue_redraw()

func FBGReset():
	for r in range(FBGRowSize):
		for c in range(FBGColSize):
			if(FBGRead(c,r) > -1):
				if (MainGridRead(c + FBGReferenceLocation.x, r + FBGReferenceLocation.y) > -1):
					RoofHit = true
					StopBlockFallTimer.emit()
				
				MainGridWrite(FBGRead(c,r), c + FBGReferenceLocation.x, r + FBGReferenceLocation.y)
				var collid = collider.instantiate()
				add_child(collid)
				collid.position = Vector2((c + FBGReferenceLocation.x) * colRenderOffset, (r + FBGReferenceLocation.y) * -rowRenderOffset)
				collisionGridWrite(collid,c + FBGReferenceLocation.x,r + FBGReferenceLocation.y)
				
	CheckForLineClear()
	FBGReferenceLocation = FBGResetPosition
	FBGDropReset = true
	#add code to change block
	FBGResetArray.emit()
	blockDropAICalCulation()


func CheckForLineClear():
	var colmsFilled = 0
	var rowsFilled = 0
	
	for r in range(FBGRowSize):
		for c in range(MGColSize):
			if(MainGridRead(c, r + FBGReferenceLocation.y) > 1):
				colmsFilled += 1
		if(colmsFilled == MGColSize):
			rowsFilled += 1
		colmsFilled = 0
	
	match rowsFilled:
		
		1:
			SendWater.emit(1)
		2:
			SendWater.emit(2)
		3:
			SendWater.emit(3)
		4:
			SendWater.emit(4)
		
		
	
func ChangeFBGArray(FBGArray: Array [int]):
	FallingBlockGrid = FBGArray
	queue_redraw()


#function to imulate setting a value in a 2D array
func collisionGridWrite(data, col: int, row: int):
	collisionGrid[(row*MGColSize)+col] = data
#function to imulate reading a value in a 2D array
func collisionGridRead(col: int, row: int):
	return collisionGrid[(row*MGColSize) + col]


#AI block placement function
func blockDropAICalCulation():
	
	#a temporary arry so i can meniputalte without messing with original
	var TempFallingBlockGrid : Array[int] = FallingBlockGrid
	#the offset found to be best
	var BestOffset : int
	#the rotation found to be best
	var BestRotaion : String
	#the highest points of best score
	var BestScore : int = 0
	
	if RoofHit:
		return
	
	#Loop through all posible Rotaions
	for Rotation in ["S", "E", "N", "W"]:
		#loop through all posible offsets
		for offset in range(-4,11):
			
			var fail : bool = false
			var score : int = 0
			
			#check if blocks could be outside of grid
			if offset < 0 || offset > 5:
				#loop through temp falling block grid
				for row in range(FBGRowSize):
					
					#breck loop if fail is active
					if fail:
						break
					
					for col in range(FBGColSize):
						
						#breck loop if fail is active
						if fail:
							break
						
						# if block at location is not empty && col with the offset is not out of bounds
						if TempFallingBlockGrid[(row*FBGColSize) + col] > -1 && (col + offset < 0 || col + offset >= 10):
							fail = true
						
			if !fail:	
				#finds what hight block will be placed
				for hight in range(FBGReferenceLocation.y, -4, -1):
					
					var stop : bool = false
					if hight >= 0:
						score += 3
					
					
					
					for row in range(FBGRowSize):
						for col in range(FBGColSize):
							
							if TempFallingBlockGrid[(row*FBGColSize) + col] > -1:
								if(row + hight) == 0:
									stop = true
									break
								#MainGridRead(c + FBGReferenceLocation.x, r + FBGReferenceLocation.y - 1) > -1 and FBGRead(c,r) > -1)
								if MainGridRead(col + offset, row + hight - 1) > -1:
									stop = true
									break
						
						if stop:
							break
					
					#calculates negitives for emptys spaces
					if stop:
						for row in range(FBGRowSize):
							for col in range(FBGColSize):
								
								for below in range(-1, -3, -1):
									if row + hight + below >= 0 && TempFallingBlockGrid[(row*FBGColSize) + col] > -1 && MainGridRead(col + offset, row + hight + below) < 0:
										score -= 2
										if(row + below >= 0) && TempFallingBlockGrid[( (row + below)*FBGColSize) + col] > -1:
											score += 2
										
						#checks for posible line clear
						var colmsFilled = 0
						var rowsFilled = 0	
						
						for r in range(FBGRowSize):
							for c in range(MGColSize):
								if(MainGridRead(c, r + hight) > 1):
									colmsFilled += 1
								else:
									if c >= offset && c < offset + FBGColSize - 1:
										if TempFallingBlockGrid[( (r)*FBGColSize) + (c - offset)] >= 0:
											colmsFilled += 1
							if(colmsFilled == MGColSize):
								rowsFilled += 1
							colmsFilled = 0
						
						score += rowsFilled * 10
						
						#removes hight score for excess rows
						
						for row in range(FBGRowSize):
							var emptyCol = 0
							for col in range(FBGColSize):
								if TempFallingBlockGrid[(row*FBGColSize) + col] >= 0:
									emptyCol += 1
							if emptyCol >= 4:
								score -= 3
							
							
						
						if score > BestScore:
							BestOffset = offset
							BestRotaion = Rotation
							BestScore = score
							print("expected offset" )
							print(offset)
							print("expected hight")
							print(hight)
							print("expected rotaion")
							print(Rotation)
							print()
							break
	
		@warning_ignore("unassigned_variable")
		var temp : Array[int]
		temp.resize(FBGColSize*FBGRowSize)
		temp.fill(-1)
		
		#coping varibles over to new grid
		for row in range(FBGRowSize):
			for col in range(FBGColSize):
				temp[(FBGColSize * (FBGRowSize - col - 1) ) + row] = TempFallingBlockGrid[(row*FBGColSize) + col]
				
		TempFallingBlockGrid = temp
		
		
	
	#creates directions for inputs
	targetOffset =  BestOffset - FBGReferenceLocation.x
	
	match BestRotaion:
		
		"S":
			targetRotaion = 0
		"E":
			targetRotaion = 1
		"W":
			targetRotaion = -1
		"N":
			targetRotaion = 2
	

#processes ai movements
func AIControlls():
	
	if RoofHit:
		return
	
	
	if targetOffset == 0 && targetRotaion == 0:
		FBGBlockFall()
		
	else:
		#does side movement
		if targetOffset > 0:
			if checkForMoveCollison(1):
				FBGReferenceLocation.x += 1
				checkFBGridOutOfBounds()
			targetOffset -= 1
		
		else:
			if targetOffset < 0:
				if checkForMoveCollison(-1):
					FBGReferenceLocation.x -= 1
					checkFBGridOutOfBounds()
				targetOffset += 1

			else: 
				if targetRotaion > 0:
					FBGRotateRight()
					targetRotaion -= 1
				
				else:
					if targetRotaion < 0:
						FBGRotateLeft()
						targetRotaion += 1



