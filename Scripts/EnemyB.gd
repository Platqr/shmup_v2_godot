extends Area2D

var fire_time = 0.0
var player_node
var new_bullet 
var shoot_on = false
var move_speed = 200
var stop_pos = 100
var stop_time = 10
var exit_dir = Vector2(0,1)
var get_out = false
var stoped = false
export var hit_points = 5
export var fire_rate = .25


func _ready():
	$Timer.set_wait_time(stop_time)
	connect("area_entered", self, "_on_EnemyB_area_entered")
	new_bullet = load("res://Scenes/EnemyBulletB.tscn")
	player_node = get_node("../Player")
	$Timer.connect("timeout", self, "_on_Timer_timeout")

func _process(delta):
	if player_node: look_at(player_node.position)
	if shoot_on: shoot()
	_move(delta)

func _move(delta):
	if position.y <= stop_pos: position += Vector2(0,1) * move_speed * delta
	elif !stoped:
		stoped = true
		shoot_on = true
		$Timer.start()
	if get_out: 
		position += exit_dir.normalized() * move_speed * delta
		if position.x >= 826:
			queue_free()
		if position.x <= 173:
			queue_free()
		if position.y >= 873:
			queue_free()
		if position.y <= 27:
			queue_free()

func shoot():
	if _get_time() - fire_time >= fire_rate:
		spawn_bullet()
		fire_time = _get_time()

func spawn_bullet():
	
	var bullet = new_bullet.instance()
	bullet.set_position(self.position)
	bullet.set_rotation_degrees(self.rotation_degrees - 90)
	get_parent().add_child(bullet)

func _get_time():
	return OS.get_ticks_msec() / 1000.0

func _damage():
	hit_points = hit_points -1
	if hit_points <= 0:
		_die()

func _die():
	$CollisionShape2D.set_deferred("disabled", true)
	hide()
	shoot_on = false
	$DeadSfx.play()
	yield($DeadSfx,"finished")
	queue_free()

func _on_EnemyB_area_entered(area):
	if area.is_in_group("pBullet"):
		_damage()

func _on_Timer_timeout():
	shoot_on = false
	get_out = true
