# Player Landing State
extends PlayerState

func state_enter() -> void:
	player.allow_h_input = self.allow_h_input
	player.allow_v_input = self.allow_v_input
	
	animation_player.play("landing")

func state_process(delta : float) -> void:
	
	player.velocity.y += player.fall_velocity * delta
	
	if !animation_player.is_playing():
		state_transition.emit(self, "idle")
	
	if Input.is_action_just_pressed("jump"):
		state_transition.emit(self, "jumping")
