class_name PlayerRunningState
extends State

@export var player: Player
@export var coyote_timer: Timer


func enter():
	player.animator.play("running")


var x_delta = 0


func process_physics(delta: float) -> State:
	var direction = Input.get_axis("move_left", "move_right")

	# 处理同时按下问题
	if direction != 0:
		x_delta = direction
	if direction == 0:
		if Input.is_action_pressed("move_left"):
			direction = x_delta
		if Input.is_action_pressed("move_right"):
			direction = -x_delta
	var movement = direction * player.max_speed

	# 翻转动画
	if !is_zero_approx(movement):
		player.graphics.scale.x = -1 if movement < 0 else 1

	var was_on_floor = player.is_on_floor()

	player.velocity.x = movement
	player.move_and_slide()

	if was_on_floor != player.is_on_floor():
		coyote_timer.start()

	if !player.is_on_floor() and coyote_timer.is_stopped():
		return player.fall_state

	# 没有左右输入事件并且预计移动距离为0，则置为idle
	if (
		not (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"))
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
