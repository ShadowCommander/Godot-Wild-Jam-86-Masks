extends PanelContainer
class_name RuneEntry

enum Verbosity {
	IconOnly,
	IconLabel,
	Description,
}

signal pressed

@export var icon: TextureRect
@export var name_label: Label
@export var button: TextureButton
@export var description: RichTextLabel
@export var verbosity: Verbosity = Verbosity.IconLabel

func _ready() -> void:
	change_verbosity(verbosity)

func change_verbosity(value: Verbosity) -> void:
	verbosity = value
	if verbosity == Verbosity.IconOnly:
		name_label.hide()
		description.hide()
	elif verbosity == Verbosity.IconLabel:
		name_label.show()
		description.hide()
	elif verbosity == Verbosity.Description:
		name_label.show()
		description.show()

func _on_texture_button_pressed() -> void:
	pressed.emit()

func populate_data(rune_data: RuneData) -> void:
	if rune_data == null:
		icon.texture = null
		name_label.text = ""
		button.tooltip_text = ""
		return
	icon.texture = rune_data.texture
	name_label.text = rune_data.name
	button.tooltip_text = rune_data.description
