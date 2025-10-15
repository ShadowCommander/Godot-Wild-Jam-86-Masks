extends Node

@onready var mask_menu: Control = $MaskMenu

@export var starting_runes: PlayerStartingRunes

var runes: Array[RuneData] = []


func _ready() -> void:
	add_default_runes()
	mask_menu.populate_runes(get_runes())

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
