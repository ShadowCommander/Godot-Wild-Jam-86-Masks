extends PanelContainer

signal pressed

@export var icon: TextureRect
@export var name_label: Label
@export var button: TextureButton

func _on_texture_button_pressed() -> void:
	pressed.emit()

func populate_data(rune_data: RuneData) -> void:
	icon.texture = rune_data.texture
	name_label.text = rune_data.name
	button.tooltip_text = rune_data.description
