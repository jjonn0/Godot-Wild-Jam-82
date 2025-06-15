extends PlayerState

var jump_velocity
var jump_gravity

func state_enter() -> void:
	
	animation_player.play("jump")
	
	player.allow_h_input = self.allow_h_input
	player.allow_v_input = self.allow_v_input
	
	jump_velocity = player.jump_velocity
	jump_gravity = player.jump_gravity
	
	player.velocity.y = jump_velocity

func state_physics(delta : float):
	
	player.velocity.y += jump_gravity * delta
	
	if player.velocity.y > 0:
		state_transition.emit(self, "falling")
