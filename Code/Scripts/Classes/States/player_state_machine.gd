# Player specific State Machine
extends StateMachine

@export var player : CharacterBody2D

# On ready, check for all child states.
# If an initial state was chosen, set as current state.
func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_transition.connect(_on_state_transition)
			
			# Give states player information
			child.player = player
	
	if initial_state:
		initial_state.state_enter()
		current_state = initial_state


func _on_player_on_damage(health: int) -> void:
	
	_on_state_transition(current_state, "damaged")

func _on_player_on_death() -> void:
	
	_on_state_transition(current_state, "death")
