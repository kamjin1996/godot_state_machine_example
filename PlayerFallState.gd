extends State

@export var player: Player

var gravity = ProjectSettings.get("physics/2d/default_gravity")


func enter() -> void:
	player.animator.play("fall")


func process_physics(delta: float) -> State:
	player.velocity.y = gravity * delta
	player.velocity.y += player.jump_force / 2
	player.move_and_slide()
	if player.is_on_floor():
		return player.idle_state
	return null
