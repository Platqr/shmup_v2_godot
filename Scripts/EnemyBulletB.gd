extends Area2D

export var b_speed = 600

func _ready():
	set_meta("type", "enemy_bullet")

func _process(delta):
	position += Vector2(0,1).rotated(rotation) * b_speed * delta
	
	if get_global_transform_with_canvas().origin.x >= 812:
		queue_free()
	if get_global_transform_with_canvas().origin.x <= 185:
		queue_free()
	if get_global_transform_with_canvas().origin.y >= 857:
		queue_free()
	if get_global_transform_with_canvas().origin.y <= 45:
		queue_free()
