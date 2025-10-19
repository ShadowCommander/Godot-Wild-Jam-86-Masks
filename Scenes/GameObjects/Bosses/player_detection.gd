extends Area2D
class_name PlayerDetectionArea

var player_detected: bool = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_detected = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_detected = false
