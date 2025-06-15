class_name Level extends Node

@export var level_number : int

var this_level : int
var current_spawn

@onready var player_scene = preload("res://Scenes/player.tscn")

func _ready() -> void:
	
	spawn_player()
	prepare_level_unload()

func spawn_player() -> void:
	
	# Search for spawn point.
	for child in get_children():
		
		if child.is_in_group("player_spawn"):
			
			current_spawn = child
			break
	
	if current_spawn == null:
		print("No spawn point found!")
		pass
	
	var player : CharacterBody2D = player_scene.instantiate()
	player.position = current_spawn.position
	
	add_child(player)

func prepare_level_unload() -> void:
	
	for child in get_children():
		
		if child.is_in_group("player_exit"):
			
			child.end_level.connect(level_unload)

func level_unload(next_level : String) -> void:
	
	Global.game_manager.change_2d_scene(next_level)
