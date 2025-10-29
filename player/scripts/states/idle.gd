class_name PlayerStateIdle extends PlayerState

func enter () -> void:
	# player idle animation
	player.sprite.play("idle")
	player.velocity.x = 0.0

func process(_delta) -> PlayerState:
	if player.direction.x != 0:
		return walk
	else:
		return self
	
func physics_process(_delta: float) -> PlayerState:
	if not player.is_on_floor():
		return fall
	return self

func handle_input (event: InputEvent) -> PlayerState:
	if event.is_action_pressed("jump"):
		return jump
	elif event.is_action_pressed("dash"):
		return dash
	elif event.is_action_pressed("attack"):
		return attack
	else:
		return self
