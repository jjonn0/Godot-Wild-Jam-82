extends Node
class_name StateMachine

var current_state : State
var states : Dictionary = {}

@export var initial_state : State

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_transition.connect(_on_state_transition)
	
	if initial_state:
		initial_state.state_enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.state_process(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.state_physics(delta)

func _on_state_transition(calling_state, new_state_name) -> void:
	
	# If the calling state is not the current state, ignore.
	if calling_state != current_state:
		return
	
	# Fetch the new state from the states dictionary.
	var new_state : State = states.get(new_state_name.to_lower())
	# If no new state exists, ignore.
	if !new_state:
		return
	
	if current_state:
		current_state.state_exit()
	
	new_state.state_enter()
	
	current_state = new_state
