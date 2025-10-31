class_name MaskGuyStateHit extends MaskGuyState

var unhit: bool = false

func enter () -> void:
	mask_guy.sprite.play("hit")
	mask_guy.velocity.x = 200.0 * mask_guy.direction
	mask_guy.velocity.y = -220.0

	await mask_guy.sprite.animation_finished
	unhit = true

func process(_delta: float) -> MaskGuyState:
	return next_state

func physics_process(_delta: float) -> MaskGuyState:
	if unhit:
		return mask_guy.prev_state
	return next_state

func exit () -> void:
	unhit = false

