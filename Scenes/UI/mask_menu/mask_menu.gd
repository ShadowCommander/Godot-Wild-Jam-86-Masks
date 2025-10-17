extends Control

const RUNE_ENTRY = preload("uid://bj2p0w3hnbpah")

@export var rune_container: GridContainer

var rune_entries: Dictionary[RuneData, Control] = {}

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
