extends CharacterBody2D

@export var speed : float = 50.0

@export var jump_height : float = 40.0
@export var time_to_peak : float = 0.6
@export var time_to_land : float = 0.4

var direction_input : float

var allow_h_input : bool = false
var allow_v_input : bool = false

@onready var jump_velocity : float = ((2.0 * jump_height) / time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / pow(time_to_peak, 2)) * -1.0
@onready var fall_velocity : float = ((-2.0 * jump_height) / pow(time_to_land, 2)) * -1.0

func _physics_process(_delta: float) -> void:
	
	# Handle left-right inputs
	direction_input = Input.get_axis("move_left", "move_right")
	if direction_input && allow_h_input:
		velocity.x = direction_input * speed
	else:
		velocity.x = 0
	
	# Flipping the character based on x velocity
	if velocity.x < 0:
		scale = Vector2(1, -1)
		rotation = deg_to_rad(180)
	elif velocity.x > 0:
		scale = Vector2(1, 1)
		rotation = deg_to_rad(0)
	
	move_and_slide()
