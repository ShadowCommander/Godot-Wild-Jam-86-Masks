extends Node

@export var player_stats: PlayerStats
@export var attack_action: GUIDEAction
@export var movement_component: MovementComponent
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

func _attack() -> void:
	var attack = player_stats.attack_combo.get(attack_combo_index)
	attack_combo_index = (attack_combo_index + 1) % player_stats.attack_combo.size()
	if attack == null:
		return
		
	# 🔹 Rotate & position the attack node
	look_direction = _get_attack_direction()
	attack_node.rotation = look_direction.angle() - deg_to_rad(90)
	attack_node.position = look_direction.normalized() * 50
	if attack_node.has_node("AttackAnimation"):
		attack_node.get_node("AttackAnimation").play("attack")

	attack_timer = attack.attack_time
	animation_player.play(attack.animation)
	
	attacking = true;


func _end_attack(_anim_name: String):
	attacking = false;
	
func _get_attack_direction():
	var target = movement_component._get_controller_target()
	return movement_component.get_look_direction(target);
