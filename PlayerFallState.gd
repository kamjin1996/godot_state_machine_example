class_name PlayerFallState
extends State

@export var player: Player

var gravity = ProjectSettings.get("physics/2d/default_gravity")


func enter() -> void:
	player.animator.play("fall")


func process_physics(delta: float) -> State:
	player.velocity.y = gravity * delta
	player.velocity.y += player.jump_heigh / 2
	player.move_and_slide()

	if player.is_on_floor():
		return player.running_state
	return null
