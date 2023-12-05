class_name PlayerRunningState
extends State

@export var player: Player


func enter():
	player.animator.play("running")


func process_physics(delta: float) -> State:
	if !player.is_on_floor():
		return player.fall_state

	var movement = Input.get_axis("move_left", "move_right") * player.max_speed

	# 翻转动画
	if !is_zero_approx(movement):
		player.sprite_2d.flip_h = movement < 0

	player.velocity.x = movement
	player.move_and_slide()

	if is_zero_approx(movement):
		return player.idle_state

	if player.is_on_floor() and Input.is_action_just_pressed("jump"):
		return player.jump_state
	return null
