extends Node
class_name StatsComponent

signal modifiers_changed(modifiers: Array[PlayerStatModifier])

@export var base_stats: Stats
var modifiers: Array[PlayerStatModifier]

@export_category("Attack")
var attack_combo: Array[AttackComboEntry]

@export_category("Speed")
var speed: float = 0

@export_category("Dash")
var dash_count: int = 0
var dash_recharge_time: float = 0
var dash_curve: Curve
var dash_time: float = 0
var dash_distance: float = 0
var dash_invincibility_time: float = 0

@export_category("Health")
var max_health: float = 0
var health_damage_invincibility_time: float = 0

func _ready() -> void:
	setup_stats()
	modifiers_changed.emit(modifiers)

func setup_stats() -> void:
	if not base_stats:
		return
	# Dictionary[PlayerStatModifier.BuffableStats, Dictionary[PlayerStatModifier.StatType, float]]
	var combined_modifiers: Dictionary[PlayerStatModifier.BuffableStats, Dictionary] = {}

	for modifier: PlayerStatModifier in modifiers:
		var type_dict: Dictionary[PlayerStatModifier.StatType, float] = combined_modifiers.get_or_add(modifier.buff_stat, {})
		var init_value = 1 if modifier.type == PlayerStatModifier.StatType.MULTIPLICATIVEMULTIPLIER or modifier.type == PlayerStatModifier.StatType.ADDITIVEMULTIPLIER else 0
		var value = type_dict.get_or_add(modifier.type, init_value)
		match modifier.type:
			PlayerStatModifier.StatType.FLAT:
				combined_modifiers[modifier.buff_stat][modifier.type] = value + modifier.value
			PlayerStatModifier.StatType.ADDITIVEMULTIPLIER:
				combined_modifiers[modifier.buff_stat][modifier.type] = value + modifier.value
			PlayerStatModifier.StatType.MULTIPLICATIVEMULTIPLIER:
				combined_modifiers[modifier.buff_stat][modifier.type] = value * (1 + modifier.value)

	if base_stats.attack_combo.size() != attack_combo.size():
		while attack_combo.size() < base_stats.attack_combo.size():
			attack_combo.append(AttackComboEntry.new())
		while attack_combo.size() > base_stats.attack_combo.size():
			attack_combo.pop_back()

	for i in base_stats.attack_combo.size():
		var base_attack: AttackComboEntry = base_stats.attack_combo[i]
		var attack: AttackComboEntry = attack_combo[i]
		attack.animation = base_attack.animation
		attack.damage = calculate_modifiers(base_attack.damage, PlayerStatModifier.BuffableStats.DAMAGE, combined_modifiers)
		attack.attack_time = base_attack.attack_time
	
	speed = calculate_modifiers(base_stats.speed, PlayerStatModifier.BuffableStats.SPEED, combined_modifiers)
	
	dash_count = ceil(calculate_modifiers(base_stats.dash_count, PlayerStatModifier.BuffableStats.DASH_COUNT, combined_modifiers))
	dash_recharge_time = calculate_modifiers(base_stats.dash_recharge_time, PlayerStatModifier.BuffableStats.DASH_RECHARGE_TIME, combined_modifiers)
	dash_curve = base_stats.dash_curve
	dash_time = calculate_modifiers(base_stats.dash_time, PlayerStatModifier.BuffableStats.DASH_TIME, combined_modifiers)
	dash_distance = calculate_modifiers(base_stats.dash_distance, PlayerStatModifier.BuffableStats.DASH_DISTANCE, combined_modifiers)
	dash_invincibility_time = calculate_modifiers(base_stats.dash_invincibility_time, PlayerStatModifier.BuffableStats.DASH_INVINCIBILITY_TIME, combined_modifiers)
	
	max_health = calculate_modifiers(base_stats.max_health, PlayerStatModifier.BuffableStats.MAX_HEALTH, combined_modifiers)
	health_damage_invincibility_time = calculate_modifiers(base_stats.health_damage_invincibility_time, PlayerStatModifier.BuffableStats.HEALTH_DAMAGE_INVINCIBILITY_TIME, combined_modifiers)

func calculate_modifiers(base_stat: float, buff_stat: PlayerStatModifier.BuffableStats, combined_modifiers: Dictionary[PlayerStatModifier.BuffableStats, Dictionary]) -> float:
	var result = base_stat
	var stat_types = combined_modifiers.get(buff_stat)
	if stat_types == null:
		return result
	var flat = stat_types.get(PlayerStatModifier.StatType.FLAT)
	if flat:
		result += flat
	var additive = stat_types.get(PlayerStatModifier.StatType.ADDITIVEMULTIPLIER)
	if additive:
		result *= additive
	var multiplicative = stat_types.get(PlayerStatModifier.StatType.MULTIPLICATIVEMULTIPLIER)
	if multiplicative:
		result *= multiplicative
	return result

func add_modifier(modifier: PlayerStatModifier) -> void:
	modifiers.append(modifier)
	modifiers_changed.emit(modifiers)

func get_attack_combo_entry(index: int) -> AttackComboEntry:
	var attack = attack_combo.get(index)
	if attack == null:
		return null
	return
