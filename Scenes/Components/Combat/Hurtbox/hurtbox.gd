class_name HurtboxComponent
extends Area2D

@export var health_component: HealthComponent

func _receive_damage(data: AttackComboEntry) -> void:
	if health_component == null:
		printerr("Hurtbox should have a HealthComponent assigned!")
		return
	
	health_component.update_health(data.damage) # Hitbox → HURTBOX → Health
