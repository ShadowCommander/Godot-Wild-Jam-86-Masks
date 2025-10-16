extends State

@onready var collision_shape_2d: CollisionShape2D = $"../../PlayerDetection/CollisionShape2D"
@onready var player_detection: Area2D = $"../../PlayerDetection"
@onready var finite_state_machine: FiniteStateMachine = $".."


var player_entered: bool = false:
	set(val):
		player_entered = val
		#collision_shape_2d.set_deferred("disabled", val)

func _ready() -> void:
	player_detection.body_entered.connect(_on_player_detection_body_entered)

func _on_player_detection_body_entered(_body: CharacterBody2D):
	if _body.is_in_group("player"):
		player_entered = true

func enter():
	super.enter()
	print("idle state entered")
	player_entered = false
	if not debug:
		return
	debug.text = "Idle"
	

func transition():
	if player_entered:
		finite_state_machine.change_state("FollowState")
