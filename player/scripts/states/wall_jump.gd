class_name PlayerStateWallJump extends PlayerState

var wall_jump_timer = 0.0

func enter () -> void:
	wall_jump_timer = 0.05
	player.velocity.x = 400 * -player.is_facing
	player.velocity.y = -500

func process(_delta) -> PlayerState:
	wall_jump_timer -= _delta
	return next_state

func physics_process(_delta: float) -> PlayerState:
	if wall_jump_timer < 0:
		return fall
	return next_state

func handle_input (event: InputEvent) -> PlayerState:
	if event.is_action_pressed("attack"):
		return attack
	return next_state
