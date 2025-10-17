extends State

@onready var rip_timer: Timer = $RipTimer


func _ready():
	rip_timer.timeout.connect(_on_rip_timer_timeout)

func enter() -> void:
	pass

func _on_rip_timer_timeout() -> void:
	pass
