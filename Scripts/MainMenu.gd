extends TextureRect


func _ready():
	$MarginContainer/HBoxContainer/VBoxContainer/PlayButton.connect("pressed", self, "_on_PlayButton_pressed")
	$MarginContainer/HBoxContainer/VBoxContainer/QuitButton.connect("pressed", self, "_on_QuitButton_pressed")
	$MarginContainer/HBoxContainer/VBoxContainer/PlayButton.grab_focus()


func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/Level1.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
