class_name HitboxComponent
extends Area2D

signal hit

var data: AttackComboEntry

func _ready() -> void:
	area_entered.connect(_on_area_entered)

# for modular and one-directional communication (Hitbox → Hurtbox → Health)
func _on_area_entered(area: Area2D) -> void:
	# Only interact with Hurtboxes
	if not area is HurtboxComponent:
		return
	
	var hurtbox := area as HurtboxComponent 
	hurtbox._receive_damage(data)
	hit.emit()

func attack(entry: AttackComboEntry) -> void:
	data = entry
