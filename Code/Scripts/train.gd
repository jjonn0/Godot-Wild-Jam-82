extends Node2D

@export var life : float = 20.0
@export var speed : float = 300.0

var current_life : float = life
var bounce_time : float = 0.0
var y_pos : float

func _ready() -> void:
	
	y_pos = position.y

func _process(delta: float) -> void:
	
	position.x -= speed * delta
	current_life -= delta
	bounce_time -= delta
	
	if current_life <= 0:
		
		queue_free()
	if bounce_time <= 0:
		
		bounce_time = randf_range(0.2, 0.7)
		
		if y_pos + position.y > 1.0:
			position.y -= 0.5
		elif y_pos - position.y < 1.0:
			position.y += 0.5
		else:
			var r = randf()
			if r > 0.5:
				position.y -= 0.5
			else:
				position.y += 0.5
