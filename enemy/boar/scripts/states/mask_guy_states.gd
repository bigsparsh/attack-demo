class_name MaskGuyState extends Node

var mask_guy: MaskGuy
var next_state: MaskGuyState

# region -> State References
@onready var idle: MaskGuyState = %Idle
@onready var roam: MaskGuyState = %Roam
@onready var hit: MaskGuyState = %Hit
# endregion

func init () -> void:
	pass

func enter () -> void:
	pass

func exit () -> void:
	pass

func process(_delta: float) -> MaskGuyState:
	return next_state

func physics_process(_delta: float) -> MaskGuyState:
	return next_state

func handle_input(_event: InputEvent) -> MaskGuyState:
	return next_state

