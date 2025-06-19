extends Node2D

## The default light state.
@export_enum("ON", "OFF") var default_state : String = "ON"
## The maximum amount of time it takes for a light to change brightness levels.
## (Minimum time is 3.0, anything lower will not cause the light to flicker.)
@export_range(0.0, 20.0, 0.5) var flicker_time : float = 0.0
## If the light state will switch upon player detection.
## Once the player is detected, the light will not change states again.
@export var state_switch_on_player_detection : bool = false

var has_player_been_detected : bool = false
var current_time : float = 0.0

@onready var point_light : PointLight2D = $LampSegment/PointLight2D

func _process(delta: float) -> void:
	
	if flicker_time >= 3.0:
		
		if current_time <= 0.0:
			
			current_time = randf_range(3.0, flicker_time)
