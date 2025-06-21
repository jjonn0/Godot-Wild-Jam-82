@icon("res://Assets/Icons/player_icon.png")
class_name Player extends CharacterBody2D
signal on_damage(health : int)
signal on_death()
signal respawn(player : CharacterBody2D)
signal update_health(health : int)
signal update_charge(time_left : float)

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
@export var state_machine : StateMachine

var direction_input : float
var allow_h_input : bool = false
var allow_v_input : bool = false
var health : int = max_health
var dead : bool = false
var current_invulnerability : float = 0.0
var flashlight_state : bool = false
var current_flashlight_time : float

# Velocity applied to the player when they jump.
@onready var jump_velocity : float = ((2.0 * jump_height) / time_to_peak) * -1.0
# The time from when the player is in the air to the apex of the jump.
@onready var jump_gravity : float = ((-2.0 * jump_height) / pow(time_to_peak, 2)) * -1.0
# The time from when the player is at the apex of the jump to when they land.
@onready var fall_velocity : float = ((-2.0 * jump_height) / pow(time_to_land, 2)) * -1.0

@onready var flashlightAudio = $FlashlightAudioPlayer
@onready var damageAudio = $DamageAudioPlayer

func _ready() -> void:
	reset()

func _process(delta: float) -> void:
	
	if current_invulnerability > 0.0:
		current_invulnerability -= delta
	
	if flashlight_state and current_flashlight_time > 0:
		current_flashlight_time -= delta
		update_charge.emit(current_flashlight_time)
	
	if state_machine.current_state != $PlayerStateMachine/Death and dead:
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
	if Input.is_action_just_pressed("flashlight_toggle") and !dead:
		toggle_light()
	
	move_and_slide()

# Handle player damage.
func take_damage(damage_points : int) -> void:
	# If the player is invulnerable, ignore.
	if current_invulnerability > 0:
		return
	
	# Deduct player health
	damageAudio.play()
	health -= damage_points
	current_invulnerability = invulnerability
	# If health is below zero, delcare the player dead and update HUD and flashlight
	if health <= 0:
		health = 0
		update_health.emit(health)
		on_death.emit()
		dead = true
		flashlight_state = true
		toggle_light()
	else:
		on_damage.emit(health)

# Reset player stats and update HUD.
func reset() -> void:
	health = max_health
	# If the player dies on an enemy, there is a brief window where they can take damage.
	# This prevents the player from taking damage when respawning.
	current_invulnerability = 0.1
	dead = false
	flashlight_state = false
	current_flashlight_time = flashlight_duration
	
	update_health.emit(health)
	update_charge.emit(current_flashlight_time)

# Unused
func flash(value : float) -> void:
	
	animated_sprite.set_instance_shader_parameter("flash_value", value)

# Flashlight toggle function.
func toggle_light() -> void:
	flashlightAudio.play()
	if flashlight_state:
		flashlight_state = false
	else:
		flashlight_state = true
	
	flashlight.visible = flashlight_state
