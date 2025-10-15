extends CharacterBody2D  # or Node2D, depending on your base type

@onready var health_component = $HealthComponent

func _ready() -> void:
	# Connect to health's died signal
	health_component.died.connect(_on_enemy_died)

func _on_enemy_died() -> void:
	print("Enemy Dummy Died!")
	_show_rune_menu()

func _show_rune_menu() -> void:
	var rune_menu = get_tree().root.get_node("Main/UICanvasLayer/RuneOptionsMenu")
	
	if rune_menu:
		# Example: preload or select your rune resources dynamically
		var runes: Array[Rune] = []
		runes.append(preload("res://Resources/Runes/EarthRune.tres"))
		runes.append(preload("res://Resources/Runes/FireRune.tres"))
		runes.append(preload("res://Resources/Runes/IceRune.tres"))
		runes.append(preload("res://Resources/Runes/WindRune.tres"))

		rune_menu.initialize(runes)
		rune_menu.visible = true
		get_tree().paused = true
