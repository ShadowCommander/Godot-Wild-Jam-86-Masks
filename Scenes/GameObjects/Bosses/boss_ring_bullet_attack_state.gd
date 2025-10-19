extends State

@export var animation_player: AnimationPlayer
@export var velocity_component: VelocityComponent
	
func enter():
	velocity_component.disabled = true
	if animation_player != null:
		animation_player.play("ring_attack")
		animation_player.animation_finished.connect(handle_animation_finished)

func handle_animation_finished() -> void:
	finite_state_machine.change_state("BossIdleState")
