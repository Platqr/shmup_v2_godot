extends Area2D

export var bp_speed = 2000

func _ready():
	connect("area_entered", self, "_on_PlayerBullet_area_entered")
	set_meta("type", "player_bullet")

func _process(delta):
	position += Vector2(0,-1) * bp_speed * delta
	
	if get_global_transform_with_canvas().origin.y <= 75:
		queue_free()
	
	
func _on_PlayerBullet_area_entered(area):
	if area.get_meta("type") == "enemy":
		queue_free()
