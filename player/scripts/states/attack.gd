class_name PlayerStateAttack extends PlayerState

var attack_timer: float = 0.0
var hit_child: int = 2
var can_attack: bool = true
var hitbox: CollisionPolygon2D

func enter () -> void:
	attack_timer = player.attack_time
	if player.direction.y == -1:
		player.hitbox.rotation = 90
		hit_child = 0
	elif player.direction.y == 1:
		if player.prev_state == fall or player.prev_state == jump:
			player.hitbox.get_node("HitBoxDown").rotation = 90 * player.is_facing
			player.hitbox.get_node("HitBoxDown").translate(Vector2(0, 0))
		else:
			return
	else:
		player.hitbox.rotation = 0
		hit_child = 2
	hitbox = player.hitbox.get_child(hit_child)
	hitbox.disabled = false
	pass

func process(delta: float) -> PlayerState:
	attack_timer -= delta
	return next_state

func physics_process(_delta: float) -> PlayerState:
	if attack_timer < 0 or not can_attack:
		return player.prev_state if player.prev_state != jump else fall
	return next_state

func exit () -> void:
	if not can_attack:
		can_attack = true
		return

	player.hitbox.rotation = 0
	hitbox.disabled = true
	pass
