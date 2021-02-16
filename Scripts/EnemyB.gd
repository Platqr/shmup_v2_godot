extends Area2D

export var hit_points = 20
var fire_time = 0.0
var player_node
export var follow = false
export var fire_rate = .25


func _ready():
	set_meta("type", "enemy")
	if follow: player_node = get_node("../Player")

func _process(_delta):
	if player_node: look_at(player_node.position)
	shoot()


func shoot():
	if get_time() - fire_time >= fire_rate:
		spawn_bullet()
		fire_time = get_time()

func spawn_bullet():
	var new_bullet = load("res://Scenes/EnemyBulletB.tscn")
	
	var bullet = new_bullet.instance()
	bullet.set_position(self.position)
	bullet.set_rotation_degrees(self.rotation_degrees - 90)
	get_parent().add_child(bullet)

func get_time():
	return OS.get_ticks_msec() / 1000.0

func Damage():
	hit_points = hit_points -1
	if hit_points <= 0:
		queue_free()


func _on_EnemyB_area_entered(area):
	if area.get_meta("type") == "player_bullet":
		Damage()
