extends Area2D

var collected : bool = false

func _on_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("player") and !collected:
		
		body.recharge_flashlight()
		collected = true
		visible = false

func respawn() -> void:
	
	collected = false
	visible = true
