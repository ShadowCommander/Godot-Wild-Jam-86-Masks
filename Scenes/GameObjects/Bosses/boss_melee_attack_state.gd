extends State

@export var animation_player: AnimationPlayer
@export var velocity_component: VelocityComponent

func enter():
	velocity_component.disabled = true
	if animation_player != null:
		animation_player.play("melee_attack")
