extends CharacterBody2D
class_name BulwarkBoss

signal died

#@onready var player = get_tree().get_first_node_in_group("player")
@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var finite_state_machine: FiniteStateMachine = $FiniteStateMachine

#
func _ready():
	velocity_component.disabled = true
#
#func _process(_delta):
	#velocity_component.accelerate_to_player()
#
#func _physics_process(_delta: float) -> void:
	#velocity_component.move(self)


func _on_health_component_died() -> void:
	died.emit()
	finite_state_machine.change_state("BossDeadState")
