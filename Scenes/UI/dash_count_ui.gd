extends HBoxContainer

const DASH_PROGRESS_BAR = preload("uid://bw165mv4ontaj")

@export var player_movement: PlayerMovementComponent

var elements: Array[ProgressBar] = []

func _ready() -> void:
	set_dash_count()
	player_movement.update_dash_ui.connect(update_ui)

func set_dash_count() -> void:
	elements.clear()
	for child in elements:
		remove_child(child)
		child.queue_free()
	for dash in range(player_movement.player_stats.dash_count):
		var progress_bar = DASH_PROGRESS_BAR.instantiate()
		add_child(progress_bar)
		elements.append(progress_bar)

func update_ui(dashes_remaining: int, dash_recharge_timer: float) -> void:
	for i in range(elements.size()):
		var bar = elements[i]
		if i == dashes_remaining:
			bar.value = dash_recharge_timer
		elif i < dashes_remaining:
			bar.value = 1.0
		elif i > dashes_remaining:
			bar.value = 0.0
