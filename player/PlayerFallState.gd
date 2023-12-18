class_name PlayerFallState
extends State

@export var player: Player

var gravity = ProjectSettings.get("physics/2d/default_gravity")
@export var hand_to_wall_checker: RayCast2D
@export var foot_to_wall_checker: RayCast2D


func enter() -> void:
	player.velocity.y = 0.0
	player.animator.play("fall")


func process_physics(delta: float) -> State:
	#下落时稍微快速点，这样可以提升体验
	player.velocity.y = gravity * delta
	player.velocity.y += player.jump_heigh
	player.move_and_slide()

	# 在墙上，并且头部射线和脚部射线都碰到墙时才置为滑墙
	if (
		player.is_on_wall()
		and hand_to_wall_checker.is_colliding()
		and foot_to_wall_checker.is_colliding()
	):
		return player.wall_sliding_state

	if player.is_on_floor():
		return player.idle_state

	return null
