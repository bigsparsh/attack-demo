class_name MaskGuyStateIdle extends MaskGuyState

var rng = RandomNumberGenerator.new()
@onready var ground: RayCast2D = %"Directed/RayCastGround"
@onready var wall: RayCast2D = %"Directed/RayCastWall"

func enter () -> void:
	mask_guy.sprite.play("idle")
	mask_guy.velocity.x = 0.0


func process(_delta: float) -> MaskGuyState:
	if rng.randi_range(0, 99) == 77:
		return roam
	return next_state

