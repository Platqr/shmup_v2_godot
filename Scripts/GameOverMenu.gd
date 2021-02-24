extends Control

var paused = false

func _ready():
	$MarginContainer/VBoxContainer/Restart.connect("pressed", self, "_on_Restart_pressed")
	$MarginContainer/VBoxContainer/Quit.connect("pressed", self, "_on_Quit_pressed")


func _on_Restart_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false

func _on_Quit_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
	get_tree().paused = false


func _on_Player_player_died():
	show()
	get_tree().paused = true
	$MarginContainer/VBoxContainer/Restart.grab_focus()
