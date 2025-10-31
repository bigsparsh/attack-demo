class_name PlayerStateWalk extends PlayerState

func enter () -> void:
	player.sprite.play("walk")
	pass

func process(_delta) -> PlayerState:
	if player.direction.x == 0:
		return idle
	return next_state

func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.speed
	if not player.is_on_floor():
		return fall
	if player.is_on_wall_only() and (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")):
		return wall_grab
	return self

func handle_input (event: InputEvent) -> PlayerState:
	if event.is_action_pressed("jump"):
		return jump
	elif event.is_action_pressed("dash"):
		return dash
	elif event.is_action_pressed("attack"):
		return attack
	return next_state
