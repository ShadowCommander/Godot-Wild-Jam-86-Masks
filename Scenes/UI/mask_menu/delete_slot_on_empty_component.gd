extends Node
class_name DeleteSlotOnEmptyComponent

@export var drag_drop_comp: DragDropControlComponent:
	set(value):
		if drag_drop_comp:
			drag_drop_comp.data_slot.data_changed.disconnect(handle_data_changed)
		drag_drop_comp = value
		drag_drop_comp.data_slot.data_changed.connect(handle_data_changed)

func handle_data_changed() -> void:
	if drag_drop_comp.data_slot.rune_data == null:
		get_parent().queue_free()
