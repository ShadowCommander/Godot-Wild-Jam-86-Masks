extends Control

const RUNE_ENTRY = preload("uid://bj2p0w3hnbpah")

@export var rune_container: GridContainer

var rune_entries: Dictionary[RuneData, Control] = {}

func populate_runes(runes: Array[RuneData]) -> void:
	for rune_data in runes:
		if rune_entries.has(rune_data):
			continue
		var rune = RUNE_ENTRY.instantiate()
		rune.populate_data(rune_data)
		rune_entries[rune_data] = rune
		rune_container.add_child(rune)
		rune_container.move_child(rune, 0)
