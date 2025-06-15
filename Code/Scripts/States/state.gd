extends Node
class_name State

signal state_transition

func state_enter() -> void:
	pass

func state_exit() -> void:
	pass

func state_process(_delta : float) -> void:
	pass

func state_physics(_delta : float) -> void:
	pass
