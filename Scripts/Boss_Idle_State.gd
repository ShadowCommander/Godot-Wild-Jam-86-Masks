extends State
class_name BossIdleState

@onready var collision_shape_2d: CollisionShape2D = $"../../PlayerDetection/CollisionShape2D"
@onready var player_detection: Area2D = $"../../PlayerDetection"

var player_entered: bool = false:
	set(val):
		player_entered = val
		collision_shape_2d.set_deferred("disabled", val)
		if val == true:
			finite_state_machine.change_state("bossfollowstate")


func _ready() -> void:
	player_detection.body_entered.connect(_on_player_detection_body_entered)


func _on_player_detection_body_entered(_body: CharacterBody2D):
	if _body.is_in_group("player"):
		player_entered = true


func enter():
	print("boss idle state")
	player_entered = false
	set_physics_process(false)
