extends Resource
class_name PlayerStats

@export_category("Attack")
@export var attack_combo: Array[AttackComboEntry]

@export_category("Speed")
@export var speed: float = 0 # 400

@export_category("Dash")
@export var dash_count: int = 0 # 3
@export var dash_recharge_time: float = 0 # 1.0 # Time in seconds for one segment to recharge
@export var dash_curve: Curve
@export var dash_time: float = 0 # 0.5
@export var dash_distance: float = 0 # 400
@export var dash_invincibility_time: float = 0

@export_category("Health")
@export var max_health: float = 0 # 10
@export var health_damage_invincibility_time: float = 0

enum BuffableStats {
	DAMAGE,
	ATTACK_SPEED,
	SPEED,
	DASH_COUNT,
	DASH_RECHARGE_TIME,
	DASH_CURVE,
	DASH_TIME,
	DASH_DISTANCE,
	DASH_INVINCIBILITY_TIME,
	MAX_HEALTH,
	HEALTH_DAMAGE_INVINCIBILITY_TIME,
}
