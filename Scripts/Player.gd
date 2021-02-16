extends Area2D

var fire_time = 0.0
export var fire_rate = .15
export var move_speed = 450
export var focus_speed = 200


func _ready():
	set_meta("type", "player")

func _process(delta):
	var m_speed = move_speed
	var velocity = Vector2()
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	elif Input.is_action_pressed("move_left"):
		velocity.x -=1
	if Input.is_action_pressed("move_up"):
		velocity.y -=1
	if Input.is_action_pressed("move_down"):
		velocity.y +=1
	if Input.is_action_pressed("focus"):
		m_speed = focus_speed
	if Input.is_action_pressed("shoot"):
		Shoot_pb()
	
	position += velocity * delta * m_speed
	position.x = clamp(position.x, 202.5, 797.5)
	position.y = clamp(position.y, 56.5, 843.5)
	

func spawn_p_bullet():
	var new_pb_bullet = load("res://Scenes/PlayerBullet.tscn")
	var pb_bullet = new_pb_bullet.instance()
	pb_bullet.set_position(self.position)
	get_parent().add_child(pb_bullet)

func Shoot_pb():
	if get_time() - fire_time >= fire_rate:
		spawn_p_bullet()
		fire_time = get_time()
	
func get_time():
	return OS.get_ticks_msec() / 1000.0
	
	
func _on_Heart_area_entered(area):
	if area.get_meta("type") == "enemy" || area.get_meta("type") == "enemy_bullet":
		hide()
		queue_free()
