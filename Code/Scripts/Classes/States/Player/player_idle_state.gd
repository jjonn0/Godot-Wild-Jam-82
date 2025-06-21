# Player Idle State
extends PlayerState

@export var max_wait_time : float = 15.0

var current_wait_time : float

func state_enter() -> void:
	player.allow_h_input = self.allow_h_input
	player.allow_v_input = self.allow_v_input
	
	# Default still idle frame.
	animation_player.play_section("idle", -1, 0, -1, 0)

func state_physics(delta : float) -> void:
	
	if Input.is_action_just_pressed("jump"):
		state_transition.emit(self, "jumping")
	
	if player.direction_input:
		state_transition.emit(self, "walking")
	
	if !player.is_on_floor():
		state_transition.emit(self, "falling")
	
	roll_animation_play(delta)

# Check to see if the animation can be played or the timer is still counting down.
func roll_animation_play(delta : float) -> void:
	
	if current_wait_time <= 0:
		current_wait_time = randf() * max_wait_time
		animation_player.play("idle")
	
	if !animation_player.is_playing() or animation_player.get_playing_speed() == 0:
		current_wait_time -= delta
