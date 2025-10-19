extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _on_health_component_died() -> void:
	print("Player died")
