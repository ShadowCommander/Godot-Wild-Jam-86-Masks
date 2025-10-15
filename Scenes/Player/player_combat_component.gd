extends Node

@export var player_stats: PlayerStats
@export var attack_action: GUIDEAction
@export var movement_component: PlayerMovementComponent
@export var animation_player: AnimationPlayer
@export var attack_node: Node2D

var attack_chambered: bool
var attack_combo_index: int
var attack_timer: float
var attacking := false
var look_direction: Vector2

func _ready():
	attack_action.triggered.connect(_attack)
	animation_player.animation_finished.connect(_end_attack)

func _physics_process(delta: float) -> void:
	if attack_timer > 0:
		attack_timer -= delta
	elif not attack_action.is_triggered():
		attack_timer = 0

func _attack() -> void:
	if attack_timer > 0:
		return
	var attack = player_stats.attack_combo.get(attack_combo_index)
	attack_combo_index = (attack_combo_index + 1) % player_stats.attack_combo.size()
	if attack == null:
		return
	attack_timer += attack.attack_time
		
	# 🔹 Rotate & position the attack node
	look_direction = _get_attack_direction()
	attack_node.look_at(look_direction)

	animation_player.play(attack.animation)
	
	attacking = true;


func _end_attack(_anim_name: String):
	attacking = false;
	
func _get_attack_direction():
	var target = movement_component._get_controller_target()
	return movement_component.get_look_direction(target);
