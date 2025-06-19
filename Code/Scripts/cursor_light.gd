extends PointLight2D

# Goes to the current cursor position.
func _process(delta: float) -> void:
	
	position = get_global_mouse_position()
