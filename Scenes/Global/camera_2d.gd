extends Camera2D

@export var followed: Node2D

func _process(delta: float) -> void:
	pass
	#global_position = lerp(global_position, followed.global_position, delta * 10)
