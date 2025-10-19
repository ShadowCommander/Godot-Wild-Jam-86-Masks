extends Node

@export var boss: Node2D
var bullet_container: BulletContainer

func _ready() -> void:
	bullet_container = get_tree().root.get_node("Main/World/BulletContainer")

func fire(pattern: BulletHellSpawnPattern) -> void:
	var bullet_arc_length = (pattern.arc_length / (pattern.amount - 1))
	for j in pattern.interations:
		for i in pattern.amount:
			var angle = bullet_arc_length * i + pattern.arc_offset
			bullet_container.fire_bullet(boss.global_position, angle, pattern.bullet_data)
		if j == pattern.interations - 1:
			continue
		await get_tree().create_timer(pattern.iteration_cooldown).timeout
