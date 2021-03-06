extends Area2D

export var speed = 2000

func _ready():
	connect("area_entered", self, "_on_PlayerBullet_area_entered")

func _process(delta):
	position += Vector2(0,-1) * speed * delta
	
	if get_global_transform_with_canvas().origin.y <= 20:
		queue_free()
	
	
func _on_PlayerBullet_area_entered(area):
	if area.is_in_group("enemy"):
		queue_free()
