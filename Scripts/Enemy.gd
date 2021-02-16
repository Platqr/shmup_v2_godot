extends Area2D

export var hit_points = 20
var fire_time = 0.0
var rot_sum = 0
var dist_beet_b
export var fire_rate = .2
export var rot_speed = 5
export var num_b_threads = 1


func _ready():
	set_meta("type", "enemy")
	if num_b_threads >= 1: dist_beet_b = 360 / num_b_threads 
	else: num_b_threads = 0

func _process(_delta):
	shoot()


func shoot():
	if get_time() - fire_time >= fire_rate:
		spawn_bullet()
		fire_time = get_time()

func spawn_bullet():
	var new_bullet = load("res://Scenes/EnemyBullet.tscn")
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

func Damage():
	hit_points = hit_points -1
	if hit_points <= 0:
		queue_free()

func _on_Enemy_area_entered(area):
	if area.get_meta("type") == "player_bullet":
		Damage()
