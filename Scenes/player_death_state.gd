extends PlayerState

func state_enter() -> void:
	
	animation_player.play("dying")

func state_process(_delta : float) -> void:
	
	if !animation_player.is_playing():
		
		state_transition.emit(self, "walking")
