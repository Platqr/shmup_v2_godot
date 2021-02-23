extends ParallaxBackground

func _process(delta):
	scroll_offset.y += 100 * delta
