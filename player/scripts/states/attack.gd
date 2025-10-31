class_name PlayerStateAttack extends PlayerState

var attack_timer: float = 0.0
var hit_child: int = 2
var can_attack: bool = true
var hitbox: CollisionPolygon2D

var org_pos = Vector2.ZERO
var org_rotation = 0.0

func enter () -> void:
	attack_timer = player.attack_time
	hitbox = player.hitbox.get_node("HitBoxHorizontal")
	org_pos = hitbox.position
	org_rotation = hitbox.rotation_degrees

	if player.direction.y == -1:
		hitbox.rotation_degrees = -90
		hitbox.translate(Vector2(10, -20))
	elif player.direction.y == 1:
		if player.prev_state == fall or player.prev_state == jump:

			hitbox.rotation_degrees = 90 
			hitbox.translate(Vector2(-10, 0))
		else:

			return

	player.hitbox.monitoring = true
	hitbox.visible = true
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

	hitbox = player.hitbox.get_node("HitBoxHorizontal")
	hitbox.position = Vector2.ZERO
	hitbox.rotation_degrees = 0.0
	player.hitbox.monitoring = false
	# hitbox.disabled = true
	hitbox.visible = false
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is MaskGuy:
		if player.direction.y == 1:
			player.velocity.y = -500.0

		body.direction = player.is_facing
		body.change_state(body.hit)
