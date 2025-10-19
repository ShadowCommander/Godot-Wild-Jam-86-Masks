extends Node

@export var player_stats: StatsComponent
@export var attack_action: GUIDEAction
@export var look_absolute: GUIDEAction
@export var look_relative: GUIDEAction
@export var movement_component: PlayerMovementComponent
@export var animation_player: AnimationPlayer
@export var attack_node: Node2D
@export var attack_box: HitboxComponent
@export var body: Node2D

var attack_chambered: bool
var attack_combo_index: int
var attack_timer: float
var attacking := false
var look_direction: Vector2

func _ready():
	attack_action.triggered.connect(_attack)
	animation_player.animation_finished.connect(_end_attack)

func _physics_process(delta: float) -> void:
	process_look(delta)
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
	#attack_node.look_at(look_direction)
	attack_node.rotation = look_direction.angle()
	attack_box.attack(attack)
	animation_player.play(attack.animation)
	
	attacking = true;

func _end_attack(_anim_name: String):
	attacking = false;

func process_look(delta: float) -> void:
	var target = _get_controller_target()
	look_direction = get_look_direction(target)
	#print(target, look_direction)

func _get_controller_target():
	var target = Vector2.INF
	
	# Looking at absolute coordinates. This is the case when we use a mouse.
	if look_absolute.is_triggered():
		target = look_absolute.value_axis_2d
	# Looking at relative coordinates. This is the case when we use a controller	
	elif look_relative.is_triggered():
		target = body.global_position + look_relative.value_axis_2d
	print(target, " ", body.global_position, " ", target - body.global_position)
	
	return target
	
func get_look_direction(target: Vector2):
	return target - body.global_position
