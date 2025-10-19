extends State

@export var body_animation_player: AnimationPlayer
@export var attack_animation_player: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func enter():
	if body_animation_player == null:
		return
	body_animation_player.play("idle")
	if attack_animation_player == null:
		return
	attack_animation_player.play("idle")
