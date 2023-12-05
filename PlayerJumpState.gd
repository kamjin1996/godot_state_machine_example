class_name PlayerJumpState
extends State

@export var player: Player

var gravity = ProjectSettings.get("physics/2d/default_gravity")


func enter():
	player.animator.play("jump")
	player.velocity.y = -player.jump_heigh


func process_physics(delta: float) -> State:
	# 给予角色重力
	player.velocity.y += gravity * delta

	# 翻转动画
	var movement = Input.get_axis("move_left", "move_right") * player.max_speed
	if !is_zero_approx(movement):
		player.sprite_2d.flip_h = movement < 0

	# 实现长按大跳，按的时间短则跳的低，但不会低于一个最低值：普通跳的设定高度
	# 参考作者：唯一Colorgamer 链接：https://zhuanlan.zhihu.com/p/285537714
	if Input.is_action_just_released("jump") and player.velocity.y < 0:
		if player.jump_heigh - abs(player.velocity.y) < player.jump_normal:
			player.velocity.y += player.jump_heigh - player.jump_normal

	player.velocity.x = movement
	player.move_and_slide()

	# 角色在下落
	if player.velocity.y > 0:
		return player.fall_state

	if player.is_on_floor():
		if movement != 0:
			return player.running_state
		return player.idle_state
	return null
