extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Local Game: Start a new local game
func _on_button_local_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/BoardGame/game_board_manager.tscn")

# Settings: Open Settings UI
func _on_button_settings_pressed() -> void:
	print("Open Settings")

# Exit: quit the game
func _on_button_exit_pressed() -> void:
	get_tree().quit()
