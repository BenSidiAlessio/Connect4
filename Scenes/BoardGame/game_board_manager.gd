extends Node2D

var board_width : int = 7
var board_height : int = 6
var offSetPosition : int = 32 # half of cell, because it gonna start from position 0 but the top right corner
var cellPixels : int = 64
var board_data : Dictionary = {}
var cell_scene = load("res://Scenes/BoardGame/cell.tscn");
var coin_scene = load("res://Scenes/BoardGame/coin.tscn");
@onready var board_container : CenterContainer = $Control/BoardContainer 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	build_board()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Build a simple board based on the values of Height with board_height variable and Width with board_width
func build_board():
	for x in board_width:
		for y in board_height:
			var xPosition = x * cellPixels + offSetPosition
			var yPosition = y * cellPixels + offSetPosition
			var cell = set_cell(Vector2i(xPosition,yPosition))
			if cell != null:
				board_data ["(" + str(x) +"," + str(y) + ")" ] = {
						"Position": Vector2i(xPosition,yPosition),
						"Cell": cell,
						"Coin": null
					}

# Generate an instance of cell at the coords passed by params
# @coords: coordination of the position of the cell
func set_cell(coords: Vector2i):
	var instance = cell_scene.instantiate()
	instance.position = coords
	board_container.add_child(instance)
	return instance

# Generate an instance of coin at the coords passed by params
# @coords: coordination of the position of the coin
func set_coin(coords: Vector2i, cell : Node2D):
	var instance = coin_scene.instantiate()
	instance.position = cell.position
	print(cell)
	board_container.add_child(instance)
	return instance

# Check on the vertical line passed as param of the board where to put the coin of the turn
# @col_num : vertical position of the grid
func add_coin_on_board(col_num : int):
	var key : String = "({0},{1})"
	for y in range(board_height, 0, -1):
		var cell = board_data[key.format([str(col_num),str(y-1)])]
		#print(cell["Coin"] == null)
		if cell["Coin"] == null and cell != null:
			cell["Coin"] = set_coin(cell["Position"], cell["Cell"])
			print(cell)
			return
			
	print("You can't place more coin!!!")
	pass


#-------------------------------------- SIGNALS ------------------------------------------
# Button column 1
func _on_column_button_pressed() -> void:
	add_coin_on_board(0)

# Button column 2
func _on_column_button_2_pressed() -> void:
	add_coin_on_board(1)

# Button column 3
func _on_column_button_3_pressed() -> void:
	add_coin_on_board(2)

# Button column 4
func _on_column_button_4_pressed() -> void:
	add_coin_on_board(3)

# Button column 5
func _on_column_button_5_pressed() -> void:
	add_coin_on_board(4)

# Button column 6
func _on_column_button_6_pressed() -> void:
	add_coin_on_board(5)

# Button column 7
func _on_column_button_7_pressed() -> void:
	add_coin_on_board(6)
