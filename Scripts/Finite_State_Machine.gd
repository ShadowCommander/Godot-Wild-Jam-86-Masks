class_name FiniteStateMachine
extends Node

var current_state: State
var previous_state: State

func _ready():
	current_state = get_child(0) as State
	previous_state = current_state
	current_state.enter()

func change_state(state):
	if find_child(state) as State == null:
		print("current state not exist")
		return
	current_state = find_child(state) as State
	current_state.enter()
	
	previous_state.exit()
	previous_state = current_state
