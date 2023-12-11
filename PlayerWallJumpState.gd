class_name PlayerWallJumpState
extends State

@export var player: Player


func enter():
	pass


func process_physics(delta: float) -> State:
	player.velocity.x = -1000 * player.get_wall_normal().x  # 根据在墙上的x法线决定移动的x的正负值
	player.move_and_slide()
	return player.jump_state
