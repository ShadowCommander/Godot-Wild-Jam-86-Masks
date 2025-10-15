extends Control

signal rune_added
@onready var runes_container = $RunesMenuPanel/RunesContainer/Runes
@onready var continue_button = $RunesMenuPanel/ButtonContainer/Button

func _ready() -> void:
	continue_button.disabled = true
	runes_container.rune_selected.connect(_on_rune_selected)

func initialize(runes: Array[Rune]) -> void:
	for i in range(min(runes.size(), runes_container.get_child_count())):
		var button = runes_container.get_child(i)
		button.rune = runes[i]
		button.texture_normal = runes[i].texture

func _on_rune_selected(rune: Rune) -> void:
	# Enable the continue button only when a rune is selected
	continue_button.disabled = rune == null

func _on_button_pressed() -> void:
	if runes_container.selected_rune:
		print("Continue with rune:", runes_container.selected_rune.name)
		emit_signal("rune_added", runes_container.selected_rune)
		get_tree().paused = false
		visible = false
