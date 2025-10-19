extends Control
class_name MaskMenu

const RUNE_ENTRY = preload("uid://bj2p0w3hnbpah")

signal mask_saved(data: Array[RuneData])

@export var rune_container: GridContainer
@export var close_menu: GUIDEAction

var rune_entries: Dictionary[RuneData, Control] = {}
var mask_slots: Array[RuneEntry] = []

func populate_runes(runes: Array[RuneData]) -> void:
	for rune_data in runes:
		if rune_entries.has(rune_data):
			continue
		create_rune(rune_data)

func create_rune(rune_data: RuneData) -> void:
	var rune: RuneEntry = RUNE_ENTRY.instantiate()
	rune.verbosity = RuneEntry.Verbosity.IconLabel
	rune.populate_data(rune_data)
	rune.tree_exiting.connect(handle_rune_tree_exiting.bind(rune_data))
	
	var drag_drop_comp = DragDropControlComponent.new()
	rune.add_child(drag_drop_comp)
	drag_drop_comp.data_slot.removable = false
	
	rune_entries[rune_data] = rune
	rune_container.add_child(rune)
	rune_container.move_child(rune, 0)
	
	drag_drop_comp.data_slot.rune_data = rune_data

func handle_rune_tree_exiting(rune_data: RuneData) -> void:
	rune_entries.erase(rune_data)

#region Load mask

@export var rune_entry: RuneEntry
@export var rune_entry_2: RuneEntry
@export var rune_entry_3: RuneEntry
@export var rune_entry_4: RuneEntry
@export var rune_entry_5: RuneEntry

func load_mask() -> void:
	pass
	# TODO load mask from resource
	mask_slots.append(rune_entry)
	mask_slots.append(rune_entry_2)
	mask_slots.append(rune_entry_3)
	mask_slots.append(rune_entry_4)
	mask_slots.append(rune_entry_5)

func get_installed_runes() -> Array[RuneData]:
	var data_list: Array[RuneData] = []
	data_list.append(rune_entry.rune_data)
	data_list.append(rune_entry_2.rune_data)
	data_list.append(rune_entry_3.rune_data)
	data_list.append(rune_entry_4.rune_data)
	data_list.append(rune_entry_5.rune_data)
	return data_list

#endregion

#region Open/close

func _on_confirm_button_pressed() -> void:
	save_and_close()

func save_and_close() -> void:
	hide()
	mask_saved.emit(get_installed_runes())
	close_menu.triggered.disconnect(save_and_close)

func open() -> void:
	close_menu.triggered.connect(save_and_close)
	show()

func _on_close_menu_out_of_bounds_texture_button_pressed() -> void:
	save_and_close()

#endregion
