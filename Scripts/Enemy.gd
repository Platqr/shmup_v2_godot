extends Area2D

var fire_time = 0.0
var rot_sum = 0
var dist_beet_b
var new_bullet 
var shoot_on = false
var rot_speed = 7.5
var fire_rate = .15
var move_speed = 200
var stop_pos = 100
var stop_time = 10
var exit_dir = Vector2(0,1)
var get_out = false
var stoped = false
export var hit_points = 5
export var num_b_threads = 1


func _ready():
	$Timer.set_wait_time(stop_time)
	if num_b_threads >= 1:
		dist_beet_b = 360 / num_b_threads
		new_bullet = load("res://Scenes/Bullets/EnemyBullet.tscn")
	else: num_b_threads = 1
	connect("area_entered", self, "_on_Enemy_area_entered")
	$Timer.connect("timeout", self, "_on_Timer_timeout")

func _process(delta):
	if shoot_on: shoot()
	_move(delta)

func _move(delta):
	if position.y <= stop_pos && !stoped: position += Vector2(0,1) * move_speed * delta
	elif !stoped:
		stoped = true
		shoot_on = true
		$Timer.start()
	if get_out: 
		position += exit_dir * move_speed * delta
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
	rot_sum += rot_speed
	var bullet
	
	if num_b_threads == 1:
		bullet = new_bullet.instance()
		bullet.set_position(self.position)
		bullet.set_rotation_degrees(0 + rot_sum)
		get_parent().add_child(bullet)
	elif num_b_threads > 1:
		for n in num_b_threads:
			bullet = new_bullet.instance()
			bullet.set_position(self.position)
			bullet.set_rotation_degrees((360 - (dist_beet_b * (n+1))) + rot_sum)
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

func _on_Enemy_area_entered(area):
	if area.is_in_group("pBullet"):
		_damage()

func _on_Timer_timeout():
	shoot_on = false
	get_out = true
