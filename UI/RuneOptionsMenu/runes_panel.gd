extends Node

signal rune_selected(rune: Rune)

var selected_rune: Rune = null

func _on_rune_selected(selected_button: TextureButton) -> void:
	for rune_button in get_children():
		if rune_button == selected_button:
			rune_button.enabled = true
			selected_rune = rune_button.rune
		else:
			rune_button.enabled = false

	# Emit signal when a rune is selected
	emit_signal("rune_selected", selected_rune)
