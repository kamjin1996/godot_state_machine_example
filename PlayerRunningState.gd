class_name PlayerRunningState
extends State

@export var player: Player
@export var coyote_timer: Timer


func enter():
	player.animator.play("running")


func process_physics(delta: float) -> State:
	var movement = Input.get_axis("move_left", "move_right") * player.max_speed

	# 翻转动画
	if !is_zero_approx(movement):
		player.sprite_2d.flip_h = movement < 0

	var was_on_floor = player.is_on_floor()

	player.velocity.x = movement
	player.move_and_slide()

	if was_on_floor != player.is_on_floor():
		coyote_timer.start()

	if !player.is_on_floor() and coyote_timer.is_stopped():
		return player.fall_state

	# 没有左右输入事件并且预计移动距离为0，则置为idle
	if (
		not (
			Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right")
		)
		and is_zero_approx(movement)
	):
		return player.idle_state

	# 玩家在地板时按下跳跃，或者郊狼时间还有剩余时按下跳跃，则允许跳跃
	var can_jump = (
		(player.is_on_floor() or !coyote_timer.is_stopped())
		and Input.is_action_just_pressed("jump")
	)

	if can_jump:
		# 开始跳跃了，停止郊狼时间倒计时
		coyote_timer.stop()
		return player.jump_state
	return null
