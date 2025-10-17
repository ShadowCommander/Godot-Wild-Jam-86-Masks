extends Control

const RUNE_ENTRY = preload("uid://bj2p0w3hnbpah")

@export var rune_container: GridContainer

var rune_entries: Dictionary[RuneData, Control] = {}

func populate_runes(runes: Array[RuneData]) -> void:
	for rune_data in runes:
		if rune_entries.has(rune_data):
			continue
		var rune: RuneEntry = RUNE_ENTRY.instantiate()
		rune.verbosity = RuneEntry.Verbosity.IconLabel
		rune.populate_data(rune_data)
		rune.tree_exiting.connect(handle_rune_tree_exiting.bind(rune_data))
		
		var drag_drop_comp = DragDropControlComponent.new()
		rune.add_child(drag_drop_comp)
		
		var delete_slot_comp = DeleteSlotOnEmptyComponent.new()
		rune.add_child(delete_slot_comp)
		
		rune_entries[rune_data] = rune
		rune_container.add_child(rune)
		rune_container.move_child(rune, 0)
		
		drag_drop_comp.data_slot.rune_data = rune_data
		delete_slot_comp.drag_drop_comp = drag_drop_comp

func handle_rune_tree_exiting(rune_data: RuneData) -> void:
	rune_entries.erase(rune_data)
