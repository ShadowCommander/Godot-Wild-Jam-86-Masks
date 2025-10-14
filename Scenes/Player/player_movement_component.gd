extends Node
class_name PlayerMovementComponent

signal update_dash_ui(dashes_remaining: int, dash_recharge_timer: float)

@export var player_stats: PlayerStats

@export var body: Node2D
@export var move_action: GUIDEAction
@export var dash_action: GUIDEAction
@export var look_absolute: GUIDEAction
@export var look_relative: GUIDEAction

func _ready() -> void:
	dash_action.triggered.connect(do_dash)
	ready_dash()

func _physics_process(delta: float) -> void:
	process_movement(delta)
	process_look(delta)
	process_dash(delta)
	
func process_movement(delta: float) -> void:
	var move = move_action.value_axis_2d.normalized() * player_stats.speed * delta
	body.position += move
	
var look_direction: Vector2

func process_look(delta: float) -> void:
	var target = Vector2.INF
	
	# Looking at absolute coordinates. This is the case when we use a mouse.
	if look_absolute.is_triggered():
		target = look_absolute.value_axis_2d
	# Looking at relative coordinates. This is the case when we use a controller	
	elif look_relative.is_triggered():
		target = body.global_position + look_relative.value_axis_2d
	
	look_direction = target - body.global_position
	
	print(target, look_direction)
	
var progress: float
	
func process_dash(delta: float) -> void:
	# Recharge dashes
	if current_dashes_available < player_stats.dash_count:
		dash_recharge_timer -= delta
		update_dash_ui.emit(current_dashes_available, 1 - (dash_recharge_timer / player_stats.dash_recharge_time))
		if dash_recharge_timer <= 0:
			current_dashes_available += 1
			dash_recharge_timer += player_stats.dash_recharge_time
	else:
		dash_recharge_timer = player_stats.dash_recharge_time

	# Dash move player
	if not dashing:
		return
	dash_timer += delta
	var distance_this_tick = player_stats.dash_curve.sample(dash_timer / player_stats.dash_time) - player_stats.dash_curve.sample(progress)
	progress = dash_timer / player_stats.dash_time
	body.position += lerp(start_position, end_position, distance_this_tick) #player_stats.curve
	if dash_timer > player_stats.dash_time:
		dashing = false

var start_position: Vector2
var end_position: Vector2
var dash_timer: float
var dashing: bool = false

var current_dashes_available: int
var dash_recharge_timer: float

func do_dash() -> void:
	if dashing:
		return
	if current_dashes_available <= 0:
		return
	start_position = Vector2.ZERO #body.global_position
	end_position = look_direction.normalized() * player_stats.dash_distance
	dashing = true
	dash_timer = 0#player_stats.dash_time
	current_dashes_available -= 1
	progress = 0

func ready_dash() -> void:
	current_dashes_available = player_stats.dash_count
