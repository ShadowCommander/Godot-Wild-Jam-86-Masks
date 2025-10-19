extends Node

@export var mask_menu: MaskMenu
@export var player_stats_comp: StatsComponent

@export var starting_runes: PlayerStartingRunes

var runes: Array[RuneData] = []

func _ready() -> void:
	add_default_runes()
	mask_menu.mask_saved.connect(handle_mask_saved)
	mask_menu.populate_runes(get_runes())
	mask_menu.open()

func handle_mask_saved(data: Array[RuneData]) -> void:
	var modifiers: Array[PlayerStatModifier] = []
	for rune: RuneData in data:
		if rune == null:
			continue
		modifiers.append_array(rune.stats_modifiers)
	player_stats_comp.set_modifiers(modifiers)

func add_default_runes() -> void:
	runes.append_array(starting_runes.runes)

#region Public

func add_rune(rune: RuneData) -> void:
	runes.append(rune)

func erase_rune(rune: RuneData) -> void:
	runes.erase(rune)

func get_runes() -> Array[RuneData]:
	return runes

#endregion
