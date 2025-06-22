extends Node2D

@export var max_time : float = 30.0
@export var min_time : float = 10.0
@export var train_path : String

var current_time : float = 0.0

func _process(delta: float) -> void:
	
	if current_time <= 0:
		current_time = randf_range(min_time, max_time)
		
		var train_scene = load(train_path)
		var train = train_scene.instantiate()
		
		add_child(train)
	
	current_time -= delta
