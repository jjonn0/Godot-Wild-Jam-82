# Player Death State
extends PlayerState

func state_enter() -> void:
	player.allow_h_input = self.allow_h_input
	player.allow_v_input = self.allow_v_input
	
	animation_player.play("dying")

func state_process(_delta : float) -> void:
	
	if !animation_player.is_playing():
		
		state_transition.emit(self, "walking")

func state_physics(delta: float) -> void:
	
	player.velocity.y += player.fall_velocity * delta
