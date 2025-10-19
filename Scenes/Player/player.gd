extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

signal died
signal health_changed(health_percentage: float)

func _on_health_component_died() -> void:
	died.emit()

func _on_health_component_health_changed(health_percentage: float) -> void:
	health_changed.emit(health_percentage)
