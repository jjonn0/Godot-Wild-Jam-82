class_name GameManager extends Node

signal on_2d_scene_change

@export var world_2d : Node2D
@export var gui : Control

@export var starting_gui_element : String
@export var starting_level : String

var current_2d_scene
var current_gui_scene

func _init() -> void:
	
	if Global.game_manager == null:
		Global.game_manager = self

func _ready() -> void:
	
	change_gui_scene(starting_gui_element)

func change_gui_scene(new_scene : String, delete : bool = true, keep_running : bool = false) -> void:
	
	if current_gui_scene != null:
		if delete:
			current_gui_scene.queue_free() # Remove scene from game.
		elif keep_running:
			current_gui_scene.visible = false # Hide scene.
		else:
			gui.current_gui_scene.remove_child() # Remove scene but save in memory.
	
	var new = load(new_scene).instantiate()
	gui.add_child(new)
	current_gui_scene = new

func change_2d_scene(new_scene : String, delete : bool = true, keep_running : bool = false) -> void:
	
	if current_2d_scene != null:
		if delete:
			current_2d_scene.queue_free() # Remove scene from game.
		elif keep_running:
			current_2d_scene.visible = false # Hide scene.
		else:
			world_2d.current_2d_scene.remove_child() # Remove scene but save in memory.
	
	var new = load(new_scene).instantiate()
	world_2d.call_deferred("add_child", new)
	current_2d_scene = new
	on_2d_scene_change.emit()
