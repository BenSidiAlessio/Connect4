extends Node2D

var board_width : int = 7;
var board_height : int = 6;
var offSetPosition : int = 32; # half of cell, because it gonna start from position 0 but the top right corner
var cellPixels : int = 64;
var board_data : Dictionary = {};
var cell_scene : PackedScene = preload("res://Scenes/BoardGame/cell.tscn");
var coin_scene : PackedScene = preload("res://Scenes/BoardGame/coin.tscn");
var players : Dictionary = {};
var number_win_coins : int  = 4
var number_win_turn : int = 3

@onready var player1_coin_texture : CompressedTexture2D = preload("res://Assets/Coins/redcoin.png");
@onready var player2_coin_texture : CompressedTexture2D = preload("res://Assets/Coins/yellowcoin.png");
@onready var board_container : CenterContainer = $Control/BoardContainer;
@onready var player_turn : int = RandomNumberGenerator.new().randf_range(1, 2); # turn generated randomically, 1 is for player 1 and 2 is for player 2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_players()
	build_board();

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
						"Coin": null,
						"Player": 0
					}

# Check on the vertical line passed as param of the board where to put the coin of the turn
# @col_num : vertical position of the grid
func add_coin_on_board(col_num : int):
	var key : String = "({0},{1})"
	for y in range(board_height, 0, -1):
		var cell = board_data[key.format([str(col_num),str(y-1)])];
		if cell["Coin"] == null and cell != null:
			cell["Coin"] = set_coin(cell["Position"], cell["Cell"]);
			cell["Player"] = player_turn;
			check_winner()
			change_turn(cell["Coin"])
			return
			
	print("You can't place more coin!!!")
	pass

func reset_board():
	players = {}
	build_board()


# Change turn to player1 for 1 to player2 for 2
func change_turn(coin : Node2D):
	var texture = players[player_turn]["player_coin_texture"]
	if player_turn == 1:
		coin.set_texture(texture)
		player_turn = 2
	else:
		player_turn = 1

# Prepare the dictionary of players with game point, stats and coin texture
func set_players():
	players[1] = {
		"player_coin_texture" = player1_coin_texture,
		"points" = 0
	}
	players[2] = {
		"player_coin_texture" = player2_coin_texture,
		"points" = 0
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
	board_container.add_child(instance)
	return instance

# Checking the winner by looking for 4 same coin on the same vertical, horizontal or oblique axe
# starting from the position of the coin passed as param
func check_winner() -> bool:
	var key : String = "({0},{1})"
	var player_checked : int = 0;
	var last_player_checked : int = 0;
	var cell_count : int = 1;
	
	# check Horizontal
	for y in board_height:
		for x in board_width:
			player_checked = board_data[key.format([str(x),str(y)])]["Player"];
			if player_checked == last_player_checked and player_checked != 0:
				cell_count += 1
			else:
				last_player_checked = player_checked
				cell_count = 1

			if cell_count == number_win_coins:
				return true
	
	cell_count = 1
	player_checked = 0
	last_player_checked = 0
	# check Vertical
	for x in board_width:
		for y in board_height:
			player_checked = board_data[key.format([str(x),str(y)])]["Player"];
			if player_checked == last_player_checked and player_checked != 0:
				cell_count += 1
			else:
				last_player_checked = player_checked
				cell_count = 1
			
			if cell_count == number_win_coins:
				return true
				
	return false

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
