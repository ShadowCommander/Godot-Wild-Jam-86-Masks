extends State

@export var animation_player: AnimationPlayer
@export var velocity_component: VelocityComponent

func enter():
	velocity_component.disabled = true
	if animation_player != null:
		animation_player.play("ring_attack")
		animation_player.animation_finished.connect(handle_animation_finished)

func handle_animation_finished(anim_name: StringName) -> void:
	var pick = randf()
	if pick < 0.65:
		finite_state_machine.change_state("BossIdleState")
	elif pick >= 0.80:
		finite_state_machine.change_state("BossFollowState")
	else:
		if pick < 0.725:
			finite_state_machine.change_state("BossBulletSwipeAttackState")
		else:
			finite_state_machine.change_state("BossRingBulletAttackState")

func exit():
	animation_player.play("idle")
