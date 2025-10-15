extends PanelContainer

signal pressed

func _on_texture_button_pressed() -> void:
	pressed.emit()
