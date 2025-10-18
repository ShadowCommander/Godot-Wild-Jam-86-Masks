extends State
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func enter():
	animation_player.play("shoot")

func exit():
	animation_player.play_backwards("shoot")
