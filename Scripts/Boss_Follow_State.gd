extends State

@onready var player = get_tree().get_first_node_in_group("player")
@onready var follow_timer: Timer = $FollowTimer
@onready var velocity_component: VelocityComponent = $"../../VelocityComponent"
@onready var bulwark_boss: CharacterBody2D = $"../.."


func _ready() -> void:
	follow_timer.timeout.connect(_on_follow_timer_timeout)


func enter():
	follow_timer.start(3.0)
	velocity_component.disabled = false

func update(_delta: float):
	velocity_component.accelerate_to_player()

func physics_update(_delta: float):
	velocity_component.move(bulwark_boss)

func exit():
	velocity_component.disabled = true
 

func _on_follow_timer_timeout():
	var pick = randi() % 2
	if pick == 0:
		finite_state_machine.change_state("BossBulletSwipeAttackState")
	elif pick == 1:
		finite_state_machine.change_state("BossRingBulletAttackState")
