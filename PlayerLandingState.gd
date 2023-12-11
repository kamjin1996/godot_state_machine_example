class_name PlayerLandingState
extends State

@export var player: Player


func enter() -> void:
	player.velocity.x = 0.0
	player.animator.play("landing")


func process_physics(delta: float) -> State:
	if not player.animator.is_playing():
		return player.idle_state
	return null
