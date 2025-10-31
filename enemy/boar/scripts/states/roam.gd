class_name MaskGuyStateRoam extends MaskGuyState

var rng = RandomNumberGenerator.new()
@onready var ground: RayCast2D = %"Directed/RayCastGround"
@onready var wall: RayCast2D = %"Directed/RayCastWall"

func enter() -> void:
	mask_guy.sprite.play("roam")


func process(_delta: float) -> MaskGuyState:
	if rng.randi_range(0, 199) == 77:
		return idle
	return next_state

func physics_process(_delta: float) -> MaskGuyState:
	if not ground.is_colliding() or wall.is_colliding():
		mask_guy.direction = -mask_guy.direction
	mask_guy.velocity.x = mask_guy.speed * mask_guy.direction
	return next_state
