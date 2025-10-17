extends Control

@onready var mask_menu: Control = $"../MaskMenu"


func _on_mask_menu_button_pressed() -> void:
	mask_menu.open()
	hide()

func _on_mask_menu_mask_saved(data: Array[RuneData]) -> void:
	show()
