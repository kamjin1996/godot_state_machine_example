extends State
class_name BoarWalkState

@export var boar: Boar


func enter():
	boar.animator.play("walk")


func process_physics(delta: float) -> State:
	boar.velocity.x = boar.walk_speed
	boar.velocity.x *= -boar.direction
	boar.move_and_slide()

	if boar.player_checker.is_colliding():
		return boar.run_state

	# 撞到墙或者是悬崖，则转身
	if !boar.cliff_checker.is_colliding() or boar.wall_checker.is_colliding():
		boar.tuning()
		return boar.idle_state

	return null



