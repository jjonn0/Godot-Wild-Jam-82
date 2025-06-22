extends Area2D

@export var end_animation_player : AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("player"):
		
		end_animation_player.play("movie")

func return_to_tile():
	
	Global.game_manager.change_gui_scene("res://Scenes/GUI/title.tscn")
	Global.game_manager.change_2d_scene("res://Scenes/GUI/blank.tscn")
