extends Area2D

var speed = 600


func _process(delta):
	position += Vector2(0,1).rotated(rotation) * speed * delta
	
	if position.x >= 826:
		queue_free()
	if position.x <= 173:
		queue_free()
	if position.y >= 873:
		queue_free()
	if position.y <= 27:
		queue_free()
