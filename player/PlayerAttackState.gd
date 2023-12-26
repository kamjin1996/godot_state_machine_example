extends State
class_name PlayerAttackState

@export var player: Player

@export var can_combo := false


func enter():
	player.animator.play("attack_1")
	can_combo = false


func process_physics(delta: float) -> State:
	if not player.animator.is_playing():
		return player.idle_state
	return null


func process_input(event: InputEvent) -> State:
	if event is InputEvent:
		if event.is_action_pressed("attack") and can_combo:
			if player.animator.current_animation == "attack_1":
				player.animator.play("attack_2")
				can_combo = false
			if player.animator.current_animation == "attack_2":
				player.animator.play("attack_3")
				can_combo = false
	return null
