class_name PlayerStateWallGrab extends PlayerState


func enter () -> void:
	player.velocity.y = 0.0
	player.gravity_multiplier = 0.75

func physics_process(_delta: float) -> PlayerState:
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		player.velocity.x = player.speed * player.direction.x
	if not player.is_on_wall():
		return fall
	return next_state

func handle_input (event: InputEvent) -> PlayerState:
	if event.is_action_pressed("jump"):
		return wall_jump
	elif event.is_action_pressed("dash"):
		return dash
	return next_state

func exit () -> void:
	player.gravity_multiplier = 1.0
