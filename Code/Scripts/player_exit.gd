extends Area2D

signal end_level(next_level : String)

@export var next_level : String

# When the player is colliding with the exit, send the end_level signal.
func _on_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("player"):
		end_level.emit(next_level)
