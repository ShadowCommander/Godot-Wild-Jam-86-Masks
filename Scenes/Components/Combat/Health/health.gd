class_name HealthComponent #class name already exists in our code, so you dont need to add it
extends Node

@export var player_stats: PlayerStats
enum UpdateType { DAMAGE, HEALING } # Type of health update, for supporting the healing mechanic
var current_health: float 
var max_health: float
var is_dead := false
var is_invincible := false # Just in case we will need to stop incoming damage

signal died

func _ready() -> void:
	max_health = player_stats.max_health;
	current_health = max_health;

# This function is using DAMAGE type by default. If healing needed call with second param equal to HEALING
func update_health(value: float, type: UpdateType = UpdateType.DAMAGE):
	match type: 
		UpdateType.DAMAGE:
			if not is_invincible:
				current_health = max(current_health - value, 0)
				print("Damage received!")
				Callable(check_death).call_deferred()
		UpdateType.HEALING:
			current_health = min(current_health + value, max_health)

func check_death():
	if current_health == 0 and not is_dead:
		died.emit()
		is_dead = true
		
		# Probably need to be refactored, right now im relate on parent to be 
		# character2d node and queue_free after emiting signal.
		# later , perbably will rewrite using signal;
		#var parent = get_parent()
		#if parent:
			#parent.queue_free()

func get_curr_health():
	return current_health
