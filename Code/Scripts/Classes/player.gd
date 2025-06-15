@icon("res://Assets/Icons/player_icon.png")
class_name Player extends CharacterBody2D
signal on_damage(health : int)
signal on_death()
signal respawn(player : CharacterBody2D)

@export_category("Player Settings")
@export var speed : float = 50.0
@export var max_health : int = 3
## Time, in seconds, it takes for the player to become vulnerable again.
@export var invulnerability : float = 1.0
## Time, in seconds, it take for the flashlight to run out.
@export var flashlight_duration : float = 60.0

@export_group("Advanced")
@export var jump_height : float = 40.0
@export var time_to_peak : float = 0.6
@export var time_to_land : float = 0.4

@export_group("Nodes")
@export var animated_sprite : AnimatedSprite2D
@export var animation_player : AnimationPlayer
@export var flashlight : PointLight2D

var direction_input : float
var allow_h_input : bool = false
var allow_v_input : bool = false
var health : int = max_health
var dead : bool = false
var current_invulnerability : float = 0.0
var flashlight_state : bool = true
var current_flashlight_time : float


@onready var jump_velocity : float = ((2.0 * jump_height) / time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / pow(time_to_peak, 2)) * -1.0
@onready var fall_velocity : float = ((-2.0 * jump_height) / pow(time_to_land, 2)) * -1.0

func _ready() -> void:
	reset()

func _process(delta: float) -> void:
	
	if current_invulnerability > 0.0:
		current_invulnerability -= delta
	
	if flashlight_state and current_flashlight_time > 0:
		current_flashlight_time -= delta
	
	if !animation_player.is_playing() and dead:
		respawn.emit(self)

func _physics_process(_delta: float) -> void:
	
	# Handle left-right inputs
	direction_input = Input.get_axis("move_left", "move_right")
	if direction_input && allow_h_input:
		velocity.x = direction_input * speed
	else:
		velocity.x = 0
	
	# Flipping the character based on x velocity
	if velocity.x < 0:
		scale = Vector2(1, -1)
		rotation = deg_to_rad(180)
	elif velocity.x > 0:
		scale = Vector2(1, 1)
		rotation = deg_to_rad(0)
	
	# Handle flashlight
	if Input.is_action_just_pressed("flashlight_toggle"):
		toggle_light()
	
	move_and_slide()

# Handle player damage.
func take_damage(damage_points : int) -> void:
	
	# If the player is invulnerable, ignore.
	if current_invulnerability > 0:
		return
	
	# Deduct player health
	health -= damage_points
	current_invulnerability = invulnerability
	if health < 0:
		on_death.emit()
		dead = true
	else:
		on_damage.emit(health)

func reset() -> void:
	health = max_health
	current_invulnerability = 0.0
	dead = false

func flash(value : float) -> void:
	
	animated_sprite.set_instance_shader_parameter("flash_value", value)

func toggle_light() -> void:
	
	if flashlight_state:
		flashlight_state = false
	else:
		flashlight_state = true
	
	flashlight.visible = flashlight_state
