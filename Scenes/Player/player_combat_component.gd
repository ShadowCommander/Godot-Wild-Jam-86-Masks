extends Node

@export var player_stats: PlayerStats
@export var attack_action: GUIDEAction
@export var animation_player: AnimationPlayer

var attack_chambered: bool
var attack_combo_index: int
var attack_timer: float

func _ready():
	attack_action.triggered.connect(_attack)

func _attack() -> void:
	var attack = player_stats.attack_combo.get(attack_combo_index)
	attack_combo_index = (attack_combo_index + 1) % player_stats.attack_combo.size()
	if attack == null:
		return

	attack_timer = attack.attack_time
	animation_player.play(attack.animation)
	
