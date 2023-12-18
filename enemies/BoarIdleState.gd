extends State
class_name BoarIdleState

@export var boar: Boar
@export var onset_timer: Timer


func enter():
	boar.animator.play("idle")
	onset_timer.start()


func process_physics(delta: float) -> State:
	if onset_timer.is_stopped():
		return boar.walk_state
	if boar.player_checker.is_colliding():
		return boar.run_state
	return null
