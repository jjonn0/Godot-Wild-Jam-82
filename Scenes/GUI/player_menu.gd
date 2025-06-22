extends Control

var isPaused:bool = false:
	set(value):
		isPaused = value
		get_tree().paused = isPaused
		visible = isPaused
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		isPaused = !isPaused


func _on_resume_button_pressed() -> void:
	isPaused = false
