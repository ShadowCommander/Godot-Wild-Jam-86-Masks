class_name FiniteStateMachine
extends Node

@onready var debug_label: Label = owner.find_child("debug_label")
@export var initial_state: State
@export var parent: CharacterBody2D
var current_state: State
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.finite_state_machine = self
			child.parent = parent
	
	if initial_state:
		change_state(initial_state.name.to_lower())

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func _input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)

func change_state(new_state_name: String) -> void:
	if current_state:
		current_state.exit()
	
	current_state = states.get(new_state_name.to_lower())
	if current_state == null:
		if debug_label:
			debug_label.text = "Unknown state"
		printerr("State not found: ", new_state_name)
		return
	if debug_label:
		debug_label.text = current_state.name
	current_state.enter()
