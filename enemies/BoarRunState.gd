extends State
class_name BoarRunState

@export var boar: Boar
@export var onset_timer: Timer


func enter():
	boar.animator.play("run")


func process_physics(delta: float) -> State:
	boar.velocity.x = boar.run_speed
	boar.velocity.x *= -boar.direction
	boar.move_and_slide()

	if !boar.cliff_checker.is_colliding() or boar.wall_checker.is_colliding():
		boar.tuning()

	if boar.player_checker.is_colliding():
		onset_timer.start()

	# 计时器停止了，转为走动状态
	if onset_timer.is_stopped():
		return boar.walk_state

	return null
