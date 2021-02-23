extends Node2D


var enemy_a
var enemy_b

func _ready():
	$MusicIntro.connect("finished", self, "_on_MusicIntro_finished")
	enemy_a = load("res://Scenes/Enemy.tscn")
	enemy_b = load("res://Scenes/EnemyB.tscn")
#	$MusicIntro.play()
	_instaniate_enemy_a(500,0,20,5,300,300,5,Vector2(-1,0))
	_instaniate_enemy_b(500,0,20,.25,300,100,7,Vector2(1,1))
	
	

func _instaniate_enemy_a(pos_x, pos_y, hp, n_threads, move_spd, stop_pos, stop_time, exit_dir):
	var enemy_a_ins = enemy_a.instance()
	enemy_a_ins.set_position(Vector2(pos_x,pos_y))
	enemy_a_ins.hit_points = hp
	enemy_a_ins.num_b_threads = n_threads
	
	enemy_a_ins.move_speed = move_spd
	enemy_a_ins.stop_pos = stop_pos
	enemy_a_ins.stop_time = stop_time
	enemy_a_ins.exit_dir = exit_dir
	
	add_child(enemy_a_ins)

func _instaniate_enemy_b(pos_x, pos_y, hp, fire_rate, move_spd, stop_pos, stop_time, exit_dir):
	var enemy_b_ins = enemy_b.instance()
	enemy_b_ins.set_position(Vector2(pos_x,pos_y))
	enemy_b_ins.hit_points = hp
	enemy_b_ins.fire_rate = fire_rate
	
	enemy_b_ins.move_speed = move_spd
	enemy_b_ins.stop_pos = stop_pos
	enemy_b_ins.stop_time = stop_time
	enemy_b_ins.exit_dir = exit_dir
	
	add_child(enemy_b_ins)
	

func _process(_delta):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
	
func _on_MusicIntro_finished():
	$MusicLoop.play()
	
