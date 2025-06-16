# Player State Class
@icon("res://Assets/Icons/player_icon.png")
extends State
class_name PlayerState

var player : CharacterBody2D

@export_category("Player State Settings")
@export var allow_h_input : bool = true
@export var allow_v_input : bool = true
@export var animation_player : AnimationPlayer
