class_name MaskGuy extends CharacterBody2D

# region -> State Machine Variables
var states: Array[MaskGuyState]
var curr_state: MaskGuyState:
	get: return states.front()
var prev_state: MaskGuyState:
	get: return states[1]
# endregion

# region -> State References
@onready var idle: MaskGuyState = %Idle
@onready var roam: MaskGuyState = %Roam
@onready var hit: MaskGuyState = %Hit
# endregion

# region -> Mask Guy Variables
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var speed: float = 100.0
@export var hit_time: float = 0.5
@export var gravity_multiplier: float = 1.0
@export var direction: float = 1.0
@export var is_facing: float:
	get: return -1 if sprite.flip_h else 1
# endregion

func _ready() -> void:
	init_states()
	pass

func init_states () -> void:
	states = []
	for state in $States.get_children():
		if state is MaskGuyState:
			states.append(state)
			state.mask_guy = self

	if states.size() == 0:
		return

	for state in states:
		state.init()
	
	change_state(curr_state)
	curr_state.enter()
	pass

func change_state (new_state: MaskGuyState) -> void:
	if new_state == null or new_state == curr_state:
		return

	print_rich("[color=Red]Mask Guy From: ", curr_state.name, " -> ", new_state.name, "[/color]")
	if curr_state:
		curr_state.exit()

	states.push_front(new_state)
	curr_state.enter()
	states.resize(3)

func _unhandled_input(event: InputEvent) -> void:
	change_state(curr_state.handle_input(event))


func _process(delta: float) -> void:
	change_state(curr_state.process(delta))

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta * gravity_multiplier
	change_state(curr_state.physics_process(delta))
	update_direction()
	$DebugLabel.text = str(direction)
	move_and_slide()


func update_direction () -> void:
	if velocity.x > 0:
		sprite.flip_h = false
		%Directed.scale.x = 1
	elif velocity.x < 0:
		sprite.flip_h = true
		%Directed.scale.x = -1
	
