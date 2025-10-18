extends State
var counter := 0

@export var animation_player: AnimationPlayer
@export var player_detection: Area2D

#var player_entered: bool = false:
	#set(val):
		#player_entered = val
		#collision_shape_2d.set_deferred("disabled", val)
		#if val == true:
			#finite_state_machine.change_state("bossshootstate")


func _ready() -> void:
	#animation_player.animation_finished.connect(_on_shoot_anim_finished)
	player_detection.body_exited.connect(_on_player_exited)

func enter():
	print("boss shoot state")
	animation_player.play("shoot")

func exit():
	animation_player.play_backwards("shoot")


func _on_player_exited(body: CharacterBody2D):
	if body.is_in_group("player"):
		finite_state_machine.change_state("bossidlestate")
