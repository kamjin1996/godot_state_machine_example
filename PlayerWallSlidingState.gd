class_name PlayerWallSlidingState
extends State

@export var player: Player

var gravity = ProjectSettings.get("physics/2d/default_gravity")


func enter():
	player.velocity.y = 0.0
	player.animator.play("wall_sliding")


func process_physics(delta: float) -> State:
	# 减少在墙上时的下落重力
	player.velocity.y = (gravity * 3) * delta

	if Input.is_action_just_pressed("jump"):
		return player.jump_state

	player.move_and_slide()

	# 依据墙的法线翻转动画
	player.graphics.scale.x = player.get_wall_normal().x

	if !player.is_on_wall():
		return player.fall_state

	if player.is_on_floor():
		return player.idle_state
	return null
