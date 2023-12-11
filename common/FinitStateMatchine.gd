# 状态机参考作者：shaggydev 链接：https://shaggydev.com/2023/10/08/godot-4-state-machines/
# 当前状态机和状态的编码又进一步解耦了其他不必要的状态值持有和少部分写法更改
class_name FinitStateMatchine
extends Node

@export var starting_state: State

var current_state: State
var last_state: State

# 当前状态花费了多长时间
var current_state_time: float

# 调试使用的计时器
var _debug_by_sec_timer: SceneTreeTimer


func _ready() -> void:
	_debug_by_sec_timer = get_tree().create_timer(1)

	starting_state._set_state_machine(self)
	current_state = starting_state
	last_state = null


func _change_state(new_state: State) -> void:
	new_state._set_state_machine(self)

	print("%s time:%s" % [current_state.name, current_state_time])
	print("[%s] %s ==> %s" % [Engine.get_physics_frames(), current_state.name, new_state.name])
	if current_state != null:
		current_state.exit()
		last_state = current_state
	current_state = new_state
	current_state.enter()
	current_state_time = 0.0


func _debug_blank():
	"""
	为了调试时留空，每计时器结束时打印内容
	"""
	if _debug_by_sec_timer.time_left <= 0:
		print(" ")
		_debug_by_sec_timer = get_tree().create_timer(1)


func process_physics(delta: float) -> void:
	_debug_blank()

	current_state_time += delta
	var new_state = current_state.process_physics(delta)
	if new_state != null:
		_change_state(new_state)


func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state != null:
		_change_state(new_state)


func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state != null:
		_change_state(new_state)
