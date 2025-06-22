extends CanvasLayer

@export var lives_control : Control
@export var life_sprite_path : String
@export var energy_bar : TextureProgressBar
@export var fps : Label

var player : Player
var lives : Array[Life]

@onready var playerMenu = %PlayerMenu
@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")


func _process(delta: float) -> void:
	
	if player == null:
		player = Global.player
		
		if player != null:
			Global.player.update_health.connect(update_player_lives)
			Global.player.on_damage.connect(update_player_lives)
			Global.player.update_charge.connect(update_player_energy)
			
			generate_lives_sprites()
			update_player_lives(Global.player.health)
	
	fps.text = str(Engine.get_frames_per_second())

# Generate the life sprites for display.
func generate_lives_sprites() -> void:
	
	for i in player.max_health:
		
		var life_node : AnimatedSprite2D = Life.new(life_sprite_path)
		life_node.name = "Life" + str(i + 1) # Add 1 to compensate how player health is counted.
		
		lives_control.add_child(life_node)
		life_node.position.x += Vector2(life_node.sprite_size).x * i * life_node.scale.x
		lives.append(life_node)

func update_player_lives(health : int) -> void:
	
	if lives.is_empty():
		print("Lives not found!")
		return
	
	for i in lives.size():
		
		var state : int = 0
		if i - health >= 0:
			state = 1
		
		lives[i].set_state(state)

func update_player_energy(time_left : float) -> void:
	
	var new_value : float = (time_left / player.flashlight_duration) * 100.0
	
	energy_bar.value = new_value

class Life extends AnimatedSprite2D:
	
	enum states {HEALTHY, DAMAGED}

	var image_path : String
	var sprite_sheet : Texture2D
	
	var texture_size : Vector2i = Vector2i(18, 8)
	var sprite_size : Vector2i = Vector2i(9, 8)
	
	func _init(image_path : String) -> void:
		
		self.image_path = image_path
		
		# Set up the sprite frames resource
		var sprite_frames : SpriteFrames = SpriteFrames.new()
		sprite_frames.add_animation("life")
		sprite_frames.set_animation_loop("life", false)
		
		sprite_sheet = load(image_path)
		var column_count : int = int(texture_size.x / sprite_size.x)
		for column in range(column_count):
			
			var frame_texture : AtlasTexture = AtlasTexture.new()
			frame_texture.atlas = sprite_sheet
			frame_texture.region = Rect2(Vector2i(column, 0) * sprite_size, sprite_size)
			sprite_frames.add_frame("life", frame_texture, column * column_count)
		
		self.sprite_frames = sprite_frames
		self.set_animation("life")
		self.scale = Vector2(5.0, 5.0)
	
	func set_state(state : int) -> void:
		
		self.set_frame(state)
		
func _ready() -> void:
	$PlayerMenu/ColorRect/VBoxContainer/MasterSlider	.value = db_to_linear(AudioServer.get_bus_volume_db(MASTER_BUS_ID))
	$PlayerMenu/ColorRect/VBoxContainer/MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(MUSIC_BUS_ID))
	$PlayerMenu/ColorRect/VBoxContainer/SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_db(SFX_BUS_ID))


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		playerMenu.visible = !playerMenu.visible

		
func _on_save_button_pressed() -> void:
	playerMenu.visible = !playerMenu.visible


func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, linear_to_db(value))


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))


func _on_exit_button_pressed() -> void:
	get_tree().quit()
