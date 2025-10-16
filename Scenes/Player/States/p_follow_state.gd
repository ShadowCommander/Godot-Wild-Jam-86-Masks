extends State

@onready var follow_timer: Timer = $FollowTimer
@onready var finite_state_machine: FiniteStateMachine = $".."

func _ready() -> void:
	follow_timer.timeout.connect(_on_follow_timer_timeout)

func enter():
	super.enter()
	owner.set_physics_process(true)
	
	print("follow state entered")
	follow_timer.start(3.0)
	print("follow timer start")
	#animation_player.play("idle")
	if not debug:
		return
	debug.text = "Follow"
 
func exit():
	super.exit()
	owner.set_physics_process(false)

func _on_follow_timer_timeout():
	finite_state_machine.change_state("IdleState")
