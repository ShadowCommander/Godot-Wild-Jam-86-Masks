extends Control

@export var boss: BulwarkBoss
@export var player: Player

@onready var boss_health_progress_bar: ProgressBar = $BossHUD/BossHealthProgressBar
@onready var player_health_progress_bar: ProgressBar = $PlayerHUD/VBoxContainer/HBoxContainer/PlayerHealthProgressBar

func _ready() -> void:
	boss.health_changed.connect(handle_boss_health_changed)
	player.health_changed.connect(handle_player_health_changed)
	
func handle_boss_health_changed(health_percentage: float) -> void:
	boss_health_progress_bar.value = health_percentage

func handle_player_health_changed(health_percentage: float) -> void:
	player_health_progress_bar.value = health_percentage
