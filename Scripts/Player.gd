extends Area2D

var fire_time = 0.0
var new_bullet
var can_shoot = true
export var fire_rate = .15
export var move_speed = 350
export var focus_speed = 150


func _ready():
	connect("area_entered", self, "_on_Player_area_entered")
	new_bullet = load("res://Scenes/PlayerBullet.tscn")

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
	if Input.is_action_pressed("shoot") && can_shoot:
		_shoot()
		if $PlayerShSfx.is_playing() == false: $PlayerShSfx.play()
	else:
		$PlayerShSfx.stop()
	
	position += velocity.normalized() * delta * m_speed
	position.x = clamp(position.x, 191, 810)
	position.y = clamp(position.y, 54, 850)
	

func _spawn_bullet():
	var bullet = new_bullet.instance()
	bullet.set_position(self.position)
	get_parent().add_child(bullet)

func _shoot():
	if _get_time() - fire_time >= fire_rate:
		_spawn_bullet()
		fire_time = _get_time()
	
func _get_time():
	return OS.get_ticks_msec() / 1000.0
	
	
func _on_Player_area_entered(area):
	if area.is_in_group("enemy") || area.is_in_group("eBullet"):
		$Collider.set_deferred("disabled", true)
		can_shoot = false
		$PlayerDeadSfx.play()
		hide()
