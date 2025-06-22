extends Node2D

@export var base_speed : float = 30.0
@export var catchup_speed : float = 50.0

var spawn_position : Vector2
var disabled : bool = true

func _ready() -> void:
	
	spawn_position = position

func _physics_process(delta: float) -> void:
	
	if !disabled:
	
		var current_speed : float = base_speed
		
		if position.distance_to(Global.player.position) > 125.0:
			
			current_speed = catchup_speed
		
		position.x += current_speed * delta

func reset() -> void:
	
	position = Vector2(spawn_position.x - 50.0, spawn_position.y)

func enable() -> void:
	
	disabled = false
