extends Enemy
class_name Boar

@export var run_speed: float = 200.0
@export var walk_speed: float = 30.0

@export var walk_state: State
@export var run_state: State
@export var idle_state: State

@onready var wall_checker: RayCast2D = $Graphcis/WallChecker
@onready var player_checker: RayCast2D = $Graphcis/PlayerChecker
@onready var cliff_checker: RayCast2D = $Graphcis/CliffChecker


# 转身
func tuning():
	self.direction = -self.direction
	self.graphcis.scale.x = self.direction


func _on_hit_box_hit(hurtbox: HurtBox) -> void:
	print("[Hit]hiter: %s >>> hurter:%s" % [self.name, hurtbox.owner.name])


func _on_hurt_box_hurt(hit_box: HitBox) -> void:
	print("[Hurt]hiter: %s >>> hurter:%s" % [hit_box.owner.name, self.name])
