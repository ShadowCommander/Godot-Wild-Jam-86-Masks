extends State
class_name BossIdleState

@export var collision_shape_2d: CollisionShape2D
@export var player_detection: Area2D
@export var animation_player: AnimationPlayer

var player_entered: bool = false:
	set(val):
		player_entered = val
		#collision_shape_2d.set_deferred("disabled", val)
		if val == true:
			finite_state_machine.change_state("bossshootstate")


func _ready() -> void:
	player_detection.body_entered.connect(_on_player_detection_body_entered)


func _on_player_detection_body_entered(_body: CharacterBody2D):
	if _body.is_in_group("player"):
		player_entered = true


func enter():
	print("boss idle state")
	player_entered = false
	set_physics_process(false)
	if animation_player != null:
		animation_player.play("idle")
