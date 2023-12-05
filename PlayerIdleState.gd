class_name PlayerIdleState
extends State

var gravity = ProjectSettings.get("physics/2d/default_gravity")

@export var player: Player


func enter() -> void:
	player.velocity.x = 0.0
	player.animator.play("idle")


func process_input(event: InputEvent) -> State:
	return null


func process_physics(delta: float) -> State:
	player.velocity.y += gravity * delta
	player.move_and_slide()

	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		return player.jump_state
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		return player.running_state

	if !player.is_on_floor():
		return player.fall_state
	return null
