extends Area2D

var fire_time = 0.0
var new_p_bullet
var canShoot = true
export var fire_rate = .15
export var move_speed = 350
export var focus_speed = 150


func _ready():
# warning-ignore:return_value_discarded
	connect("area_entered", self, "_on_Player_area_entered")
	new_p_bullet = load("res://Scenes/PlayerBullet.tscn")

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
	if Input.is_action_pressed("shoot") && canShoot:
		Shoot_pb()
		if $PlayerShSfx.is_playing() == false: $PlayerShSfx.play()
	else:
		$PlayerShSfx.stop()
	
	position += velocity * delta * m_speed
	position.x = clamp(position.x, 202.5, 797.5)
	position.y = clamp(position.y, 56.5, 843.5)
	

func spawn_p_bullet():
	var p_bullet = new_p_bullet.instance()
	p_bullet.set_position(self.position)
	get_parent().add_child(p_bullet)

func Shoot_pb():
	if get_time() - fire_time >= fire_rate:
		spawn_p_bullet()
		fire_time = get_time()
	
func get_time():
	return OS.get_ticks_msec() / 1000.0
	
	
func _on_Player_area_entered(area):
	if area.is_in_group("enemy") || area.is_in_group("eBullet"):
		$Collider.set_deferred("disabled", true)
		canShoot = false
		$PlayerDeadSfx.play()
		hide()
