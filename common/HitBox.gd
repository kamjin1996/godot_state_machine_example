class_name HitBox
extends Area2D

signal hit(huntbox: HurtBox)


func _init() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(hurtbox: HurtBox) -> void:
	hit.emit(hurtbox)
	hurtbox.hurt.emit(self)
