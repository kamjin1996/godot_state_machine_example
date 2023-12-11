# 长按大跳手感优化参考作者：唯一Colorgamer 链接：https://zhuanlan.zhihu.com/p/285537714
class_name PlayerJumpState
extends State

@export var player: Player

var gravity = ProjectSettings.get("physics/2d/default_gravity")

@export var gravity_scale: float = 1.0


func enter():
	player.velocity.y = 0.0
	player.animator.play("jump")
	player.velocity.y = -player.jump_heigh


func flip_h_jump_animation(movement: float):
	if state_machine.last_state == player.wall_sliding_state:
		# 这里不清楚为什么需要取反，但是取反动画朝向就正常了
		movement = -movement

	# 如果玩家有输入 则翻转动画
	if !is_zero_approx(movement):
		player.graphics.scale.x = -1 if movement < 0 else 1


func process_physics(delta: float) -> State:
	# 给予角色重力
	player.velocity.y += gravity * delta

	var movement = Input.get_axis("move_left", "move_right") * player.max_speed

	# 翻转动画
	flip_h_jump_animation(movement)

	# 手感优化：实现长按大跳，按的时间短则跳的低，但不会低于一个最低值：普通跳的设定高度
	if Input.is_action_just_released("jump") and player.velocity.y < 0:
		if player.jump_heigh - abs(player.velocity.y) < player.jump_normal:
			player.velocity.y += player.jump_heigh - player.jump_normal

	# 手感优化：如果玩家单侧头部撞到了东西，则自动帮玩家避开
	var jump_offset: float
	if (
		player.right_outer.is_colliding()
		and !player.center_inner.is_colliding()
		and !player.left_outer.is_colliding()
	):
		jump_offset = -100.0
	elif (
		player.left_outer.is_colliding()
		and !player.center_inner.is_colliding()
		and !player.right_outer.is_colliding()
	):
		jump_offset = 100.0

	player.velocity.x = movement + jump_offset
	player.move_and_slide()

	# 角色在下落
	if player.velocity.y > 0:
		return player.fall_state

	if player.is_on_floor():
		if movement != 0:
			return player.running_state
		return player.idle_state
	return null
