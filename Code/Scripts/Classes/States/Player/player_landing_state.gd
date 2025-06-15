extends PlayerState

func state_enter() -> void:
	
	animation_player.play("landing")
	
	player.allow_h_input = self.allow_h_input
	player.allow_v_input = self.allow_v_input

func state_process(delta : float) -> void:
	
	if !animation_player.is_playing():
		state_transition.emit(self, "idle")
