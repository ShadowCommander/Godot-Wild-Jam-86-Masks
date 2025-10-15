extends Node
class_name HealthComponent

signal death
signal health_changed

@export var max_health: float = 100
var current_health: float

func _ready():
	current_health = max_health

func damage(amount: float):
	current_health = max(current_health - amount, 0)
	health_changed.emit()
	Callable(check_health).call_deferred()

func get_health_percent():
	if max_health <= 0:
		return 0
	return min(current_health / max_health, 1)

func check_health():
	if current_health == 0:
		death.emit()
		owner.queue_free()
