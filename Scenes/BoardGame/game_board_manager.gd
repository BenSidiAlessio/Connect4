extends Node2D

var board_width : int = 7
var board_height : int = 6
var offSetPosition : int = 32 # half of cell, because it gonna start from position 0 but the top right corner
var cellPixels : int = 64
var board_data : Dictionary = {}
var cell_scene = load("res://Scenes/BoardGame/cell.tscn");
@onready var board_container : CenterContainer 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	board_container = $Control/BoardContainer 
	for x in board_width:
		for y in board_height:
			var xPosition = x * cellPixels + offSetPosition
			var yPosition = y * cellPixels + offSetPosition
			var cell = set_cell(Vector2i(xPosition,yPosition))
			if cell != null:
				board_data [str(Vector2i(xPosition,yPosition))] = {
						"Cell": cell,
						"State": "Empty"
					}
			
	print(board_data)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_cell(coords: Vector2i):
	var instance = cell_scene.instantiate()
	instance.position = coords
	board_container.add_child(instance)
	return instance
