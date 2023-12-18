class_name Enemy
extends CharacterBody2D

enum DirectionEnum { LEFT = -1, RIGHT = 1 }

# 默认朝向左边
@export var direction: DirectionEnum = DirectionEnum.LEFT:
	set(v):
		direction = v
		if not is_node_ready():
			await ready
		graphcis.scale.x = -direction

@export var graphcis: Node2D
@export var animator: AnimationPlayer
@onready var finit_state_matchine: FinitStateMatchine = $FinitStateMatchine as FinitStateMatchine


func _ready() -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	finit_state_matchine.process_input(event)


func _physics_process(delta: float) -> void:
	finit_state_matchine.process_physics(delta)


func _process(delta: float) -> void:
	finit_state_matchine.process_frame(delta)
