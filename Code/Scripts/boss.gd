extends AnimatedSprite2D

@export var speed : float = 30.0

var spawn_position : Vector2

func _ready() -> void:
	
	spawn_position = position

func _process(delta: float) -> void:
	
	position.x += speed * delta

func reset() -> void:
	
	position = Vector2(spawn_position.x - 50.0, spawn_position.y)
