# Player Falling State
extends PlayerState

var fall_velocity : float

func state_enter() -> void:
	player.allow_h_input = self.allow_h_input
	player.allow_v_input = self.allow_v_input
	
	animation_player.play("falling")
	
	fall_velocity = player.fall_velocity

func state_physics(delta : float) -> void:
	
	player.velocity.y += fall_velocity * delta
	
	if player.is_on_floor():
		state_transition.emit(self, "landing")
