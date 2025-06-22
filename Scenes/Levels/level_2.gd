extends Level

@export var boss_enemy : AnimatedSprite2D

func _ready() -> void:
	
	spawn_player()
	set_camera()
	prepare_level_unload()
	
	# Find all PointLight2Ds and record their default alpha value.
	var light_nodes = search_for_nodes(get_children(), [], "hauntable_light")
	for node in light_nodes:
		
		#lights[node] = node.energy
		lights[node] = node.color.a
	
	player.on_death.connect(on_player_death)

func on_player_death() -> void:
	
	if current_spawn != null:
		boss_enemy.reset()
