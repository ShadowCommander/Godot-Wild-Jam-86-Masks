extends Node
class_name DragDropControlComponent

class DataSlot:
	signal data_changed
	
	var rune_data: RuneData:
		set(value):
			rune_data = value
			data_changed.emit()

@export var initial_rune_data: RuneData
var rune_entry: RuneEntry

var data_slot: DataSlot = DataSlot.new()

var filled : bool = false

func _ready() -> void:
	data_slot.rune_data = initial_rune_data
	data_slot.data_changed.connect(handle_data_changed)
	var parent = get_parent()
	if parent is RuneEntry:
		rune_entry = parent
	if rune_entry != null:
		if data_slot.rune_data != null:
			rune_entry.populate_data(data_slot.rune_data)
		rune_entry.set_drag_forwarding(get_drag_data, can_drop_data, drop_data)

func get_drag_data(_at_position):
	rune_entry.set_drag_preview(get_preview())
	print("GetDragData")
	return data_slot
 
func can_drop_data(_pos, data):
	return data.rune_data is RuneData
 
func drop_data(_pos, data):
	var temp = data_slot.rune_data
	data_slot.rune_data = data.rune_data
	data.rune_data = temp
	
	rune_entry.populate_data(data_slot.rune_data)
 
func get_preview():
	var preview_texture = TextureRect.new()
	
	if data_slot.rune_data != null:
		preview_texture.texture = data_slot.rune_data.texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(30,30)
 
	var preview = Control.new()
	preview.add_child(preview_texture)
 
	return preview

func handle_data_changed() -> void:
	rune_entry.populate_data(data_slot.rune_data)
