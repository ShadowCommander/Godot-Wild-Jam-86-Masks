extends Node2D
class_name Bullet

@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var visible_on_screen_enabler_2d: VisibleOnScreenEnabler2D = $VisibleOnScreenEnabler2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible_on_screen_enabler_2d.screen_exited.connect(_on_screen_exited)


func _physics_process(_delta: float) -> void:
	velocity_component.move(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_screen_exited() -> void:
	queue_free()


func get_velocity_component():
	return velocity_component
