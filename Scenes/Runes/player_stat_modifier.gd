extends Resource
class_name PlayerStatModifier

#@export_category("Attack")
#@export var damage_flat: float = 0
#@export var damage_multiplier: float = 0
#
#@export_category("Speed")
#@export var speed_flat: float = 0
#@export var speed_multiplier: float = 0
#
#@export_category("Dash")
#@export var dash_count: int = 0
#@export var dash_recharge_time_flat: float = 0 # Time in seconds for one segment to recharge
#@export var dash_recharge_time_multiplier: float = 0
#@export var dash_time_flat: float = 0
#@export var dash_time_multiplier: float = 0
#@export var dash_distance_flat: float = 0
#@export var dash_distance_multiplier: float = 0
#
#@export_category("Health")
#@export var max_health_flat: float = 0
#@export var max_health_multiplier: float = 0

enum BuffableStats {
	NONE,
	DAMAGE,
	ATTACK_SPEED,
	SPEED,
	DASH_COUNT,
	DASH_RECHARGE_TIME,
	DASH_TIME,
	DASH_DISTANCE,
	DASH_INVINCIBILITY_TIME,
	MAX_HEALTH,
	HEALTH_DAMAGE_INVINCIBILITY_TIME,
}

enum StatType {
	NONE,
	FLAT,
	ADDITIVEMULTIPLIER,
	MULTIPLICATIVEMULTIPLIER,
}

@export var buff_stat: BuffableStats
@export var type: StatType
@export var value: float
