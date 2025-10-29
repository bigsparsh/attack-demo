class_name PlayerStateJump extends PlayerState


func enter () -> void:
	player.sprite.play("jump")
	# player.add_debug_indicator(Color.LIME_GREEN)
	player.velocity.y = player.jump_velocity
	pass

func process(_delta) -> PlayerState:
	return next_state

func physics_process(_delta: float) -> PlayerState:
	if player.is_on_wall() and (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")):
		return wall_grab
	if not player.is_on_floor() and player.velocity.y >= 0.0:
		# player.add_debug_indicator(Color.YELLOW)
		return fall
	player.velocity.x = player.direction.x * player.speed
	return next_state

func handle_input (event: InputEvent) -> PlayerState:
	if event.is_action_released("jump"):
		player.velocity.y *= player.jump_limiter
	elif event.is_action_pressed("attack"):
		return attack
	elif event.is_action_pressed("dash"):
		return dash
	return next_state

