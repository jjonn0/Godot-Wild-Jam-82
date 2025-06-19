# Basic enemy A.I. following a Path2D
class_name BasicEnemy extends Node2D

@export var sprite : AnimatedSprite2D
@export var speed : float
@export var path : PathFollow2D

var last_pos : Vector2
var current_pos : Vector2

func _physics_process(delta: float) -> void:
	
	# Take the last position and compare it to the current position.
	last_pos = path.position
	path.progress += speed * delta
	current_pos = path.position
	
	# Use the difference between the two positions to determine direction.
	if (current_pos.x - last_pos.x) < 0.0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
