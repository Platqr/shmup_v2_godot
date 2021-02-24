extends Area2D

signal player_died

var fire_time = 0.0
var new_bullet
var can_play = true
export var lives = 4
export var fire_rate = .1
export var move_speed = 450
export var focus_speed = 150


func _ready():
	connect("area_entered", self, "_on_Player_area_entered")
	$InvincibleTimer.connect("timeout", self, "_on_InvincibleTimer_timeout")
	new_bullet = load("res://Scenes/Bullets/PlayerBullet.tscn")

func _process(delta):
	var m_speed = move_speed
	var velocity = Vector2()
	if Input.is_action_pressed("move_right") && can_play:
		velocity.x += 1
	elif Input.is_action_pressed("move_left") && can_play:
		velocity.x -=1
	if Input.is_action_pressed("move_up") && can_play:
		velocity.y -=1
	if Input.is_action_pressed("move_down") && can_play:
		velocity.y +=1
	if Input.is_action_pressed("focus") && can_play:
		m_speed = focus_speed
	if Input.is_action_pressed("shoot") && can_play:
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
	
func _respawn():
	show()
	can_play = true
	position = Vector2(500,800)
	$InvincibleTimer.start()

func _damage():
	lives -= 1
	$Collider.set_deferred("disabled", true)
	hide()
	can_play = false
	$PlayerDeadSfx.play()
	if lives > 0: _respawn()
	else: emit_signal("player_died")

func _on_Player_area_entered(area):
	if area.is_in_group("enemy") || area.is_in_group("eBullet"):
		_damage()
		


func _on_InvincibleTimer_timeout():
	$Collider.set_disabled(false)
