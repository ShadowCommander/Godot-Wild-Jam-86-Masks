extends State

@onready var charge_radius: PlayerDetectionArea = $"../../ChargeRadius"

func enter():
	charge_radius.body_entered.connect(handle_area_shape_entered)

func exit():
	charge_radius.body_entered.disconnect(handle_area_shape_entered)

func handle_area_shape_entered(body: Node2D) -> void:
	if not body is Player:
		return
	var pick = randi() % 4
	if pick == 0:
		finite_state_machine.change_state("BossBulletSwipeAttackState")
	elif pick == 1:
		finite_state_machine.change_state("BossRingBulletAttackState")
	else:
		finite_state_machine.change_state("BossFollowState")
