extends State
class_name BossIdleState

@export var collision_shape_2d: CollisionShape2D
@export var player_detection: PlayerDetectionArea
@export var charge_radius: PlayerDetectionArea
@export var animation_player: AnimationPlayer
@export var velocity_component: VelocityComponent

func physics_update(delta: float):
	if player_detection.player_detected:
		finite_state_machine.change_state("BossMeleeAttackState")
	elif charge_radius.player_detected:
		finite_state_machine.change_state("BossChargeAttackState")

func enter():
	velocity_component.disabled = true
	if animation_player != null:
		animation_player.play("idle")
