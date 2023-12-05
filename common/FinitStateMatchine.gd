# 状态机参考作者：shaggydev 链接：https://shaggydev.com/2023/10/08/godot-4-state-machines/
# 当前状态机和状态的编码又进一步解耦了其他不必要的状态值持有和少部分写法更改
class_name FinitStateMatchine
extends Node

@export var starting_state: State

var current_state: State


func _ready() -> void:
	current_state = starting_state


func change_state(new_state: State) -> void:
	print("current_state:%s new_state:%s" % [current_state.name, new_state.name])
	if current_state != null:
		current_state.exit()
	current_state = new_state
	current_state.enter()


func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state != null:
		change_state(new_state)


func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state != null:
		change_state(new_state)


func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state != null:
		change_state(new_state)
