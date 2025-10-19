class_name HealthComponent #class name already exists in our code, so you dont need to add it
extends Node

@export var player_stats: StatsComponent
enum UpdateType { DAMAGE, HEALING } # Type of health update, for supporting the healing mechanic
var current_health: float
var is_dead := false
var is_invincible := false # Just in case we will need to stop incoming damage
var invincible_timer: float = 0

signal died
signal health_changed(health_percentage: float)

func _ready() -> void:
	# Must be run after StatsComponent
	player_stats.stats_changed.connect(handle_stats_changed)

func handle_stats_changed() -> void:
	current_health = player_stats.max_health;

func _physics_process(delta: float) -> void:
	if invincible_timer > 0:
		invincible_timer -= delta

# This function is using DAMAGE type by default. If healing needed call with second param equal to HEALING
func update_health(value: float, type: UpdateType = UpdateType.DAMAGE):
	match type: 
		UpdateType.DAMAGE:
			if not is_invincible and invincible_timer <= 0:
				current_health = max(current_health - value, 0)
				health_changed.emit(current_health / player_stats.max_health)
				if player_stats.health_damage_invincibility_time > 0:
					invincible_timer = player_stats.health_damage_invincibility_time
				print("Damage received!")
				Callable(check_death).call_deferred()
		UpdateType.HEALING:
			current_health = min(current_health + value, player_stats.max_health)

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
