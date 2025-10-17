extends TextureButton
class_name BossNode

@onready var panel: Panel = $Panel
@export var boss: Bosses
@onready var line_2d: Line2D = $Line2D

var enabled: bool = false:
	set(value):
		enabled = value
		$Panel.show_behind_parent = value
		

func _ready() -> void:
	if get_parent() is not BossNode:
		enabled = true
		var bosses = get_children()
		for boss in bosses:
			if boss is BossNode and boss.get_parent().enabled:
				boss.disabled = false
	if boss:
		texture_normal = boss.texture
		
func _draw():
	if get_parent() is BossNode:
		draw_line(global_position + size/2, get_parent().global_position, Color.GREEN, 1.0)

func _on_pressed() -> void:
	print("Boss pressed:", boss)

	# Enable this boss
	enabled = true
	panel.show_behind_parent = true

	# 🔹 Disable all other siblings
	var siblings = get_parent().get_children()
	for node in siblings:
		if node is BossNode and node != self:
			_disable_branch(node)

	# 🔹 Unlock this boss’s children
	var bosses = get_children()
	for child in bosses:
		if child is BossNode and child.get_parent().enabled:
			child.disabled = false
	#get_parent()._on_boss_selected(self)  # Notify parent container

func _disable_branch(node: BossNode) -> void:
	node.enabled = false
	node.disabled = true
	node.panel.show_behind_parent = false
	for child in node.get_children():
		if child is BossNode:
			_disable_branch(child)
