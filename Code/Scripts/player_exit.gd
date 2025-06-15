extends Area2D

signal end_level(next_level : String)

@export var next_level : String

func _on_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("player"):
		end_level.emit(next_level)
