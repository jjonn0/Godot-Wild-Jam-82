extends Control

var time : float = 7.0

func _process(delta : float) -> void:
	
	if time <= 0:
		Global.game_manager.change_gui_scene("res://Scenes/GUI/title.tscn")
	
	time -= delta
