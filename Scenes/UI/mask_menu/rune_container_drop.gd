extends Node

@onready var mask_menu: Control = $"../../../../../../.."

func _ready() -> void:
	get_parent().set_drag_forwarding(get_drag_data, can_drop_data, drop_data)

func get_drag_data(_at_position):
	return null
 
func can_drop_data(_pos, data):
	return data.rune_data is RuneData
 
func drop_data(_pos, data):
	data.rune_data = null
