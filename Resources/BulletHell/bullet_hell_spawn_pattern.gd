extends Resource
class_name BulletHellSpawnPattern

# Size of the arc to spread the bullets in degrees
@export var arc_length: float
# The amount of bullets fired in this pattern
@export var amount: int
# Offset of the initial arc in degrees
@export var arc_offset: float
# Amount of times to repeat
@export var interations: int
@export var iteration_cooldown: float = 0.1

@export var bullet_data: BulletData
