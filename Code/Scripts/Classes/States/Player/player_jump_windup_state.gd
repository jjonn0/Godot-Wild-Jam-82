# Player Jump Windup State
extends PlayerState

func state_enter() -> void:
	player.allow_h_input = self.allow_h_input
	player.allow_v_input = self.allow_v_input
	
	animation_player.play_section("jump_windup")

func state_process(delta : float) -> void:
	
	if !animation_player.is_playing():
		state_transition.emit(self, "jumping")
