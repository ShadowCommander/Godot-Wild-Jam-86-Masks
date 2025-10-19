extends State
class_name BossIdleState

@export var collision_shape_2d: CollisionShape2D
@export var player_detection: PlayerDetectionArea
@export var charge_radius: PlayerDetectionArea
@export var animation_player: AnimationPlayer
@export var velocity_component: VelocityComponent
@export var idle_timer: Timer

func enter():
	velocity_component.disabled = true
	if animation_player != null:
		animation_player.play("idle")
	idle_timer.start(1.0)

func _on_idle_timer_timeout() -> void:
	var pick = randi() % 4
	if pick == 0:
		finite_state_machine.change_state("BossBulletSwipeAttackState")
	elif pick == 1:
		finite_state_machine.change_state("BossRingBulletAttackState")
	else:
		finite_state_machine.change_state("BossFollowState")
