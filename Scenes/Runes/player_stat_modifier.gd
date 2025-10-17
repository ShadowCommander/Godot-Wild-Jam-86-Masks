extends Resource
class_name PlayerStatModifier

@export_category("Speed")
@export var speed_flat: float = 0
@export var speed_multiplier: float = 0

@export_category("Dash")
@export var dash_count: int = 0
@export var dash_recharge_time_flat: float = 0 # Time in seconds for one segment to recharge
@export var dash_recharge_time_multiplier: float = 0
@export var dash_time_flat: float = 0
@export var dash_time_multiplier: float = 0
@export var dash_distance_flat: float = 0
@export var dash_distance_multiplier: float = 0

@export_category("Health")
@export var max_health_flat: float = 0
@export var max_health_multiplier: float = 0
