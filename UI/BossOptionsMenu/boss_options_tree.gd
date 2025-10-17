extends Control

signal rune_added
@onready var bosses_container = $RunesMenuPanel/RunesContainer/Runes
@onready var continue_button = $VboxContainer/Button

func _ready() -> void:
	continue_button.disabled = true

func _on_rune_selected(rune: Rune) -> void:
	# Enable the continue button only when a rune is selected
	continue_button.disabled = rune == null

#func _on_button_pressed() -> void:
	#if runes_container.selected_rune:
		#print("Continue with rune:", runes_container.selected_rune.name)
		#emit_signal("rune_added", runes_container.selected_rune)
		#get_tree().paused = false
		#visible = false
