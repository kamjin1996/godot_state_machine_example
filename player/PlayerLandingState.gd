class_name PlayerLandingState
extends State

@export var player: Player


func enter() -> void:
	player.velocity.x = 0.0
	player.animator.play("landing")


func process_physics(delta: float) -> State:
	if !Input.get_axis("move_left", "move_right") == 0:
		return player.running_state
	return null
