extends Area2D

var fire_time = 0.0
var rot_sum = 0
var dist_beet_b
var new_bullet 
var shootOn = false
export var hit_points = 10
export var fire_rate = .2
export var rot_speed = 5
export var num_b_threads = 1


func _ready():
	if num_b_threads >= 1:
		dist_beet_b = 360 / num_b_threads
		new_bullet = load("res://Scenes/EnemyBullet.tscn")
	else: num_b_threads = 0
# warning-ignore:return_value_discarded
	connect("area_entered", self, "_on_Enemy_area_entered")
	
	shootOn=true

func _process(_delta):
	if shootOn: shoot()


func shoot():
	if get_time() - fire_time >= fire_rate:
		spawn_bullet()
		fire_time = get_time()

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
	

func get_time():
	return OS.get_ticks_msec() / 1000.0

func damage():
	hit_points = hit_points -1
	if hit_points <= 0:
		die()

func die():
	$CollisionShape2D.set_deferred("disabled", true)
	hide()
	shootOn = false
	$DeadSfx.play()
	yield($DeadSfx,"finished")
	queue_free()

func _on_Enemy_area_entered(area):
	if area.is_in_group("pBullet"):
		damage()
