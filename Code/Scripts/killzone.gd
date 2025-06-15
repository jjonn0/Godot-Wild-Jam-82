extends Area2D

@export var damage_points : int

func _on_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("player"):
		
		body.take_damage(damage_points)
