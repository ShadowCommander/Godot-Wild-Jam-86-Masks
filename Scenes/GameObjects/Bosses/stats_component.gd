extends Node
class_name StatsComponent

signal modifiers_changed(modifiers: Array[PlayerStatModifier])

@export var base_stats: Stats
var modifiers: Array[PlayerStatModifier]

func _ready() -> void:
	modifiers_changed.emit(modifiers)

func add_modifier(modifier: PlayerStatModifier) -> void:
	modifiers.append(modifier)
	modifiers_changed.emit(modifiers)
