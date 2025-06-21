extends Control

# When the start button is pressed, load the first level and GUI.
func _on_play_button_pressed() -> void:
	
	Global.game_manager.change_2d_scene("res://Scenes/Levels/level_1.tscn")
	Global.game_manager.change_gui_scene("res://Scenes/GUI/hud.tscn")

# When the exit button is pressed, quit the game.
func _on_exit_button_pressed() -> void:
	
	get_tree().quit()
