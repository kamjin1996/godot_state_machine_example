class_name Player
extends CharacterBody2D

@onready var finit_state_matchine: FinitStateMatchine = $FinitStateMatchine as FinitStateMatchine

@export var animator: AnimationPlayer
@export var graphics: Node2D

@export var left_outer: RayCast2D
@export var center_inner: RayCast2D
@export var right_outer: RayCast2D

@export var jump_heigh: float
@export var jump_normal: float
@export var max_speed: float
@export var acceleration: float = 400.0

@export var jump_state: State
@export var fall_state: State
@export var running_state: State
@export var idle_state: State
@export var wall_sliding_state: State


func _ready() -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	finit_state_matchine.process_input(event)


func _physics_process(delta: float) -> void:
	finit_state_matchine.process_physics(delta)


func _process(delta: float) -> void:
	finit_state_matchine.process_frame(delta)
