extends Control

@onready var audio_menu: Control = %AudioMenu


# When the start button is pressed, load the first level and GUI.
func _on_play_button_pressed() -> void:
	
	Global.game_manager.change_2d_scene("res://Scenes/Levels/tutorial_level.tscn")
	Global.game_manager.change_gui_scene("res://Scenes/GUI/hud.tscn")

# When the exit button is pressed, quit the game.
func _on_exit_button_pressed() -> void:
	
	get_tree().quit()


func _on_menu_button_pressed() -> void:
	audio_menu.visible = true


func _on_ready() -> void:
	%AudioMenu.visible = false
	

func _on_save_button_pressed() -> void:
	audio_menu.visible = false
