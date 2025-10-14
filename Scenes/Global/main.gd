extends Node

@export var mapping_contexts: Array[GUIDEMappingContext]

func _ready() -> void:
	for context in mapping_contexts:
		GUIDE.enable_mapping_context(context)
