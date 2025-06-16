# Player Walking State
extends PlayerState

func state_enter() -> void:
	player.allow_h_input = self.allow_h_input
	player.allow_v_input = self.allow_v_input
	
	animation_player.play("walking")

func state_physics(delta : float) -> void:
	
	if Input.is_action_just_pressed("jump"):
		state_transition.emit(self, "jumpwindup")
	
	if !player.direction_input:
		state_transition.emit(self, "idle")
	
	if !player.is_on_floor():
		state_transition.emit(self, "falling")
