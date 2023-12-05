class_name PlayerJumpState
extends State

@export var player: Player

var gravity = ProjectSettings.get("physics/2d/default_gravity")


func enter():
	player.animator.play("jump")
	player.velocity.y = -player.jump_force


func process_physics(delta: float) -> State:
	# 给予角色重力
	player.velocity.y += gravity * delta

	# 角色在下落
	if player.velocity.y > 0:
		return player.fall_state

	# 翻转动画
	var movement = Input.get_axis("move_left", "move_right") * player.max_speed
	if !is_zero_approx(movement):
		player.sprite_2d.flip_h = movement < 0

	player.velocity.x = movement
	player.move_and_slide()

	if player.is_on_floor():
		if movement != 0:
			return player.running_state
		return player.idle_state
	return null
