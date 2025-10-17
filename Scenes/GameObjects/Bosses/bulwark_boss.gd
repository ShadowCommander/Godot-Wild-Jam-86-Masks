extends CharacterBody2D

#@onready var player = get_tree().get_first_node_in_group("player")
#@onready var velocity_component: VelocityComponent = $VelocityComponent
#
func _ready():
	set_physics_process(false)
#
#func _process(_delta):
	#velocity_component.accelerate_to_player()
#
#func _physics_process(_delta: float) -> void:
	#velocity_component.move(self)
