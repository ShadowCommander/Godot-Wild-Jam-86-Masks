extends Node2D
class_name BulletContainer

const POOLED_BULLET = preload("uid://d28l0c5wd4jxv")

@export var player: Player

var node_pool: NodePool = NodePool.new()

func _ready() -> void:
	node_pool.set_pooled_node(POOLED_BULLET)
	node_pool.container = self
	add_child(node_pool)

func fire_bullet(spawn_pos: Vector2, angle: float, bullet_data: BulletData):
	var bullet: PooledBullet = node_pool.get_pooled()
	move_child(bullet, 0)
	bullet.bullet_data = bullet_data
	bullet.collision_layer = bullet_data.collision_layer
	bullet.collision_mask = bullet_data.collision_mask
	bullet.collision.connect(handle_bullet_collision.bind(bullet))
	
	#print(node_pool.active_counter[0], " +1")
	
	var bullet_spawn_dir = deg_to_rad(angle)
	if bullet_data.point_toward_player:
		var player_direction = spawn_pos.angle_to(player.global_position)
		bullet_spawn_dir += player_direction
	fire(bullet, spawn_pos, Vector2.from_angle(bullet_spawn_dir), 30)

var counter = 0.0
func _physics_process(delta: float) -> void:
	for bullet in node_pool.pool:
		if not bullet.is_processing() or not bullet.is_physics_processing():
			continue
		move_and_check_collision(bullet, delta)
		bullet.lifetime += delta
		if bullet.lifetime > bullet.bullet_data.lifetime:
			node_pool.set_pooled_active(bullet, false)

	#counter += delta
	#if counter > 1.0:
		#counter -= 1.0
		#print(node_pool.active_counter[0])

func move_and_check_collision(bullet: PooledBullet, _delta: float) -> void:
	#bullet.move_and_slide()
	#if bullet.get_slide_collision_count() <= 0:
		#return
	
	var collision = bullet.move_and_collide(bullet.velocity * _delta)
	if not collision:
		return
	
	if do_impact(bullet, collision):
		node_pool.set_pooled_active(bullet, false)
	#print(node_pool.active_counter[0], " -1")

func do_impact(bullet: PooledBullet, collision) -> bool:
	#var collision = bullet.get_slide_collision(0)
	var node: Node = collision.get_collider()
	# Only interact with Hurtboxes
	if node is not HurtboxComponent:
		return false
	var hurtbox := node as HurtboxComponent 
	hurtbox._receive_damage(bullet.bullet_data.combo_entry)
	return true

func fire(node: PooledBullet, player_global_position: Vector2, bullet_spawn_dir: Vector2, offset: float) -> void:
	node.global_position = player_global_position + (bullet_spawn_dir * offset)
	node.global_rotation = bullet_spawn_dir.angle()
	node.velocity = Vector2.from_angle(node.global_rotation) * node.bullet_data.speed
	print(node.velocity)
	node.reset_physics_interpolation()

func handle_bullet_collision(bullet: PooledBullet) -> void:
	node_pool.set_pooled_active(bullet, false)
