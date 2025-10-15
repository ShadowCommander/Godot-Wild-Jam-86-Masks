extends TextureButton

@export var rune: Rune
var enabled: bool = false:
	set(value):
		enabled = value
		$Panel.show_behind_parent = value

func _ready() -> void:
	if rune:
		texture_normal = rune.texture

func _on_pressed() -> void:
	print("ON PRESSED")
	get_parent()._on_rune_selected(self)  # Notify parent container
