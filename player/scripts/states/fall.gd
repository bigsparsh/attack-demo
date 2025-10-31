class_name PlayerStateFall extends PlayerState

var coyote_timer: float = 0.0
var bfr_jump_timer: float = 0.0

func enter () -> void:
	player.sprite.play("fall")
	if player.prev_state == walk:
		coyote_timer = player.coyote_time
	player.gravity_multiplier = 1.650
	pass

func process(delta) -> PlayerState:
	coyote_timer -= delta
	bfr_jump_timer -= delta
	return next_state

func physics_process(_delta: float) -> PlayerState:
	if player.is_on_wall_only() and player.prev_state == dash:
		return wall_grab
	if player.is_on_floor():
		# player.add_debug_indicator(Color.RED)
		if bfr_jump_timer > 0:
			return jump
		return idle
	player.velocity.x = player.direction.x * player.speed
	if player.is_on_wall() and (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")):
		return wall_grab
	return next_state

func handle_input (event: InputEvent) -> PlayerState:
	if event.is_action_pressed("dash"):
		return dash
	elif event.is_action_pressed("attack"):
		return attack
	elif event.is_action_pressed("jump"):
		if coyote_timer > 0.0:
			return jump
		else:
			# player.add_debug_indicator(Color.BLACK)
			bfr_jump_timer = player.jump_buffer
	return next_state

func exit () -> void:
	player.gravity_multiplier = 1.0
