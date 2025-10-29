class_name PlayerState extends Node

var player: Player
var next_state: PlayerState 

# region -> State References
@onready var idle: PlayerState = %Idle
@onready var fall: PlayerState = %Fall
@onready var jump: PlayerState = %Jump
@onready var walk: PlayerState = %Walk
@onready var dash: PlayerState = %Dash
@onready var attack: PlayerState = %Attack
@onready var wall_grab: PlayerState = %WallGrab
@onready var wall_jump: PlayerState = %WallJump
# endregion

func init() -> void: 
	pass

func enter () -> void:
	pass

func exit () -> void:
	pass

# Handle input
func handle_input (_event: InputEvent) -> PlayerState:
	return next_state

func process(_delta) -> PlayerState:
	return next_state

func physics_process(_delta: float) -> PlayerState:
	return next_state
