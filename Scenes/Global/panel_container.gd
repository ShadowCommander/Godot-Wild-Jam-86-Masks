extends PanelContainer

@onready var game_over_panel_container: PanelContainer = $GameOverPanelContainer
@onready var win_panel_container: PanelContainer = $WinPanelContainer

@export var boss: BulwarkBoss
@export var player: Player

func _ready() -> void:
	boss.died.connect(handle_boss_died)
	player.died.connect(handle_player_died)

func handle_boss_died() -> void:
	win_panel_container.show()

func handle_player_died() -> void:
	game_over_panel_container.show()
