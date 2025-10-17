extends State

@onready var player = get_tree().get_first_node_in_group("player")
@onready var follow_timer: Timer = $FollowTimer
@onready var velocity_component: VelocityComponent = $"../../VelocityComponent"
@onready var bulwark_boss: CharacterBody2D = $"../.."


func _ready() -> void:
	follow_timer.timeout.connect(_on_follow_timer_timeout)


func enter():	
	print("follow state entered")
	follow_timer.start(3.0)
	print("follow timer start")
	set_physics_process(true)

func update(_delta: float):
	velocity_component.accelerate_to_player()

func physics_update(_delta: float):
	velocity_component.move(bulwark_boss)

func exit():
	set_physics_process(false)
 

func _on_follow_timer_timeout():
	finite_state_machine.change_state("bossidlestate")
