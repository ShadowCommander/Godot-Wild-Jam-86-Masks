extends Node2D
class_name BulletSpawnerComp

var theta: float = 0.0
@export_range(0,2*PI) var alpha: float = 0.0
@export var bullet_scene: PackedScene
@onready var xtimer: Timer = $Timer


func _ready() -> void:
	#pass
	xtimer.timeout.connect(_on_timer_timeout)

func get_vec2_from_angle(angle: float) -> Vector2:
	theta = angle + alpha
	return Vector2(cos(theta), sin(theta))

func shoot_bullet(angle: float):
	var bullet_instance = bullet_scene.instantiate() as Bullet
	if bullet_instance is not Bullet:
		return
	
	var bullet_group = get_tree().get_first_node_in_group("bullet_entities")
	if bullet_group != null:
		bullet_group.add_child.call(bullet_instance)
	
	bullet_instance.position = global_position
	bullet_instance.reset_physics_interpolation()
	#var vel_comp = bullet_instance.get_velocity_component()
	var vel_comp = bullet_instance.velocity_component
	if vel_comp == null:
		print("no vel comp")
		return
	vel_comp.accelerate_in_direction(get_vec2_from_angle(angle))


func _on_timer_timeout():
	shoot_bullet(theta)
