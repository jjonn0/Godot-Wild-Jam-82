class_name Level extends Node

@export var haunt_length : float = 1.5
@export var camera_left_cutoff : int = -1000000
@export var camera_top_cutoff : int = -1000000
@export var camera_right_cutoff : int = 1000000
@export var camera_bottom_cutoff : int = 1000000

var this_level : int
var current_spawn : Marker2D
var lights : Dictionary
#var active_haunt : bool = false
var current_haunt_time : float
var player : CharacterBody2D

@onready var player_scene = preload("res://Scenes/player.tscn")

func _ready() -> void:
	
	spawn_player()
	set_camera()
	prepare_level_unload()
	
	# Find all PointLight2Ds and record their default alpha value.
	var light_nodes = search_for_nodes(get_children(), [], "hauntable_light")
	for node in light_nodes:
		
		#lights[node] = node.energy
		lights[node] = node.color.a

func _process(delta: float) -> void:
	
	global_haunting(delta)

func spawn_player() -> void:
	
	# Search for spawn point.
	for child in get_children():
		
		# Use a recursive function to search through all lower nodes.
		# Returns the player spawn marker or null.
		var player_spawn : Marker2D = search_for_node(child, "player_spawn")
		
		if player_spawn != null:
			
			current_spawn = player_spawn
			break
	
	if current_spawn == null:
		print("No spawn point found!")
		return
	
	player = player_scene.instantiate()
	player.position = current_spawn.position
	
	current_spawn.get_parent().add_child(player)
	player.respawn.connect(on_player_death)
	player.on_damage.connect(start_haunting)
	Global.player = player

func prepare_level_unload() -> void:
	
	for child in get_children():
		
		if child.is_in_group("player_exit"):
			
			child.end_level.connect(level_unload)

func level_unload(next_level : String) -> void:
	
	Global.game_manager.change_2d_scene(next_level)

func on_player_death(player : CharacterBody2D) -> void:
	
	if current_spawn != null:
		player.position = current_spawn.position
		player.reset()

# Uses recursion to search through all lower nodes.
# If the current node is not the player spawn, search through its children.
# After all nodes have been exhausted, returns null.
func search_for_node(child : Node, group : String) -> Node:
	
	var children : Array[Node] = child.get_children()
	
	if child.is_in_group(group):
		
		return child
	
	for c in children:
		
		if c.is_in_group(group):
			
			return c
		
		search_for_node(c, group)
	
	return null

func search_for_nodes(search_children : Array[Node], return_children : Array[Node], group : String) -> Array[Node]:
	
	
	# For every child in the node:
	for child in search_children:
		
		# If the child matches, append the child.
		if child.is_in_group(group):
			return_children.append(child)
		
		if search_children.is_empty():
			return return_children
		
		search_for_nodes(child.get_children(), return_children, group)
	
	return return_children

func global_haunting(delta : float) -> void:
	
	if current_haunt_time > 0.0:
			
			
		for light in lights:
				
			var r_energy = randf()
			light.color.a = r_energy
		
		current_haunt_time -= delta
		
	elif current_haunt_time > -1.0:
		for light in lights:
			
			light.color.a = lights[light]
		current_haunt_time = -1.0

func start_haunting(health : int) -> void:
	
	current_haunt_time = haunt_length

func set_camera() -> void:
	
	var camera : Camera2D = search_for_node(player, "player_camera")
	
	camera.set_limit(SIDE_BOTTOM, camera_bottom_cutoff)
	camera.set_limit(SIDE_RIGHT, camera_right_cutoff)
	camera.set_limit(SIDE_TOP, camera_top_cutoff)
	camera.set_limit(SIDE_LEFT, camera_left_cutoff)
