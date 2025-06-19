extends Area2D

# How much damage is applied to the player.
@export var damage_points : int

# Array of all currently colliding bodies.
var bodies : Array[Node2D]

func _on_body_entered(body: Node2D) -> void:
	
	bodies = get_overlapping_bodies()

func _on_body_exited(body: Node2D) -> void:
	
	if bodies.has(body):
		
		bodies.erase(body)

func _physics_process(delta: float) -> void:
	
	if !bodies.is_empty():
		for body in bodies:
		
			if body.is_in_group("player"):
				damage_player(body)

func damage_player(body : Node2D):
	
	body.take_damage(damage_points)
