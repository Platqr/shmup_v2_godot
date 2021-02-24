extends Control

var paused = false
var player_is_dead = false

func _ready():
	$MarginContainer/VBoxContainer/Continue.connect("pressed", self, "_on_Continue_pressed")
	$MarginContainer/VBoxContainer/Restart.connect("pressed", self, "_on_Restart_pressed")
	$MarginContainer/VBoxContainer/Quit.connect("pressed", self, "_on_Quit_pressed")


func _process(_delta):
	if Input.is_action_just_pressed("pause") && !player_is_dead:
		get_tree().paused = !get_tree().paused
		visible = !visible
		$MarginContainer/VBoxContainer/Continue.grab_focus()

func _on_Continue_pressed():
	get_tree().paused = false
	visible = !visible

func _on_Restart_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false

func _on_Quit_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
	get_tree().paused = false


func _on_Player_player_died():
	player_is_dead = true
