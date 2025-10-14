extends Resource
class_name PlayerStats


@export var attack_combo: Array[AttackComboEntry]

@export var speed: float = 400

@export var dash_count: int = 3
@export var dash_recharge_time: float = 1.0 # Time in seconds for one segment to recharge
@export var dash_curve: Curve
@export var dash_time: float = 0.5
@export var dash_distance: float = 400

# Start position
# End position
# Time
# Current position based on curve
