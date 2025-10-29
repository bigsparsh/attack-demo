class_name PlayerStateDash extends PlayerState

var dash_timer: float = 0.0

func enter () -> void:
	if not player.can_dash:
		return
	player.sprite.play("dash")
	player.gravity_multiplier = 0.0
	dash_timer = player.dash_time
	player.velocity.x = player.dash_speed * (-player.is_facing if player.prev_state == wall_grab else player.is_facing)
	player.velocity.y = 0.0

func process(delta) -> PlayerState:
	dash_timer -= delta
	return next_state

func physics_process(_delta: float) -> PlayerState:
	if dash_timer < 0:
		return fall
	return next_state

func exit () -> void:
	if player.can_dash:
		player.can_dash = false
		var dash_cld = get_tree().create_timer(player.dash_cooldown)
		dash_cld.timeout.connect(func ():
			player.can_dash = true
		)
		player.gravity_multiplier = 1.0
		player.add_debug_indicator(Color.PAPAYA_WHIP)
	pass
