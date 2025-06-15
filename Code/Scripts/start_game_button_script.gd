extends Button


func _on_pressed() -> void:
	
	Global.game_manager.change_2d_scene("res://Scenes/Levels/tutorial_level.tscn")
	Global.game_manager.change_gui_scene("res://Scenes/GUI/hud.tscn")
