class_name HurtboxComponent
extends Area2D

@export var health_component: HealthComponent

func _receive_damage(damage: float) -> void:
	if health_component == null:
		printerr("Hurtbox should have a HealthComponent assigned!")
		return
	
	health_component.update_health(damage) # Hitbox → HURTBOX → Health
