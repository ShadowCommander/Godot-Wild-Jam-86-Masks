extends CharacterBody2D
class_name PooledBullet

signal collision

@onready var hitbox_component: HitboxComponent = $HitboxComponent

var bullet_data: BulletData:
	set(value):
		bullet_data = value
		hitbox_component.damage = bullet_data.damage

var lifetime: float = 0

func _on_hitbox_component_hit() -> void:
	collision.emit()
