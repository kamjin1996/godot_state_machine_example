class_name State
extends Node

var state_machine: FinitStateMatchine


func _set_state_machine(v):
	state_machine = v


func enter():
	pass


func exit():
	pass


func process_physics(delta: float) -> State:
	return null


func process_input(event: InputEvent) -> State:
	return null


func process_frame(delta: float) -> State:
	return null
