extends Resource
class_name BulletData

@export var combo_entry: AttackComboEntry
@export var damage: int = 10
@export var speed: float = 20000
@export var point_toward_player: bool = false
@export var track_player: bool = false
# e.g. bullet decal, RPG explosion, incendiary 
@export var impact_effects: Array = []
@export var lifetime: float = 30
@export var collision_layer: int
@export var collision_mask: int = 1
