class_name Player extends CharacterBody2D

const DEBUG_JUMP_INDICATOR = preload("uid://citt3u707rxip")

# region -> State Machine Variables
var states: Array[ PlayerState ]
var curr_state: PlayerState:
	get : return states.front()
var prev_state: PlayerState:
	get : return states[1]
# endregion


# region -> Player Variables
@export var speed: float = 300.0 
@export var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") / 1.2
@export var gravity_multiplier: float = 1.0
@export var jump_velocity: float = -500.0
@export var jump_buffer: float = 0.2
@export var jump_limiter: float = 0.4
@export var dash_time: float = 0.15
@export var dash_speed: float = 1000.0
@export var dash_cooldown: float = 0.25
@export var can_dash: bool = true
@export var coyote_time: float = 0.05
@export var attack_time: float = 0.025

@onready var direction: Vector2 = Vector2.ZERO
var prev_direction: Vector2 = Vector2.ZERO
var is_facing: int = 1:
	get : return -1 if sprite.flip_h else 1
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var hitbox: Area2D = %"Directed/Area2D"

# endregion


func _ready() -> void:
	initialize_states()
	pass

func _process(_delta: float) -> void:
	update_direction()
	debug_hitbox_vis()
	change_state(curr_state.process(_delta))


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta * gravity_multiplier
	move_and_slide()
	change_state(curr_state.physics_process(delta))

func _unhandled_input(event: InputEvent) -> void:
	change_state( curr_state.handle_input(event))

func initialize_states () -> void:
	states = []
	for state in $States.get_children():
		if state is PlayerState:
			states.append(state)
			state.player = self

	if states.size() == 0:
		return
	
	for state in states: 
		state.init()

	change_state(curr_state)
	curr_state.enter()
	$DebugLabel.text = curr_state.name


func change_state (new_state: PlayerState) -> void:
	if new_state == null or curr_state == new_state:
		return
	
	print_rich("[color=Green]Player From: ", curr_state.name, " -> ", new_state.name, "[/color]")
	if curr_state:
		curr_state.exit()

	states.push_front(new_state)
	curr_state.enter()
	states.resize(3)
	$DebugLabel.text = curr_state.name

func debug_hitbox_vis():
	for child in hitbox.get_children():
		if child.disabled:
			child.modulate = Color.RED
		else:
			child.modulate = Color.GREEN

func update_direction () -> void:
	if velocity.x > 0:
		%Directed.scale.x = 1
		sprite.flip_h = false
	elif velocity.x < 0:
		%Directed.scale.x = -1
		sprite.flip_h = true

	# prev_direction = get_last_motion()
	direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("up", "down"))

func add_debug_indicator (color: Color = Color.RED) -> void:
	var dji: Node2D = DEBUG_JUMP_INDICATOR.instantiate()
	get_tree().root.add_child(dji)
	dji.global_position = global_position
	dji.modulate = color
	await get_tree().create_timer( 3.0 ).timeout
	get_tree().root.remove_child(dji)
