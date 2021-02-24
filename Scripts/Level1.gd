extends Node2D


var enemy_a
var enemy_b
var wave = 0

func _ready():
	$MusicIntro.connect("finished", self, "_on_MusicIntro_finished")
	$Timer.connect("timeout", self, "_on_Timer_timeout")
	enemy_a = load("res://Scenes/Enemies/Enemy.tscn")
	enemy_b = load("res://Scenes/Enemies/EnemyB.tscn")
	$MusicIntro.play()
	$Timer.start()

func _instaniate_enemy_a(pos_x, stop_pos, hp, n_threads, move_spd, stop_time, exit_dir):
	var enemy_a_ins = enemy_a.instance()
	enemy_a_ins.set_position(Vector2(pos_x,0))
	enemy_a_ins.hit_points = hp
	enemy_a_ins.num_b_threads = n_threads
	
	enemy_a_ins.move_speed = move_spd
	enemy_a_ins.stop_pos = stop_pos
	enemy_a_ins.stop_time = stop_time
	enemy_a_ins.exit_dir = exit_dir
	
	add_child(enemy_a_ins)

func _instaniate_enemy_b(pos_x, stop_pos, hp, fire_rate, move_spd, stop_time, exit_dir):
	var enemy_b_ins = enemy_b.instance()
	enemy_b_ins.set_position(Vector2(pos_x,0))
	enemy_b_ins.hit_points = hp
	enemy_b_ins.fire_rate = fire_rate
	
	enemy_b_ins.move_speed = move_spd
	enemy_b_ins.stop_pos = stop_pos
	enemy_b_ins.stop_time = stop_time
	enemy_b_ins.exit_dir = exit_dir
	
	add_child(enemy_b_ins)

func _on_MusicIntro_finished():
	$MusicLoop.play()

func _on_Timer_timeout():
	match wave:
		0:
			_instaniate_enemy_b(275,250,15,.5,300,3,Vector2(1,1))
			$Timer.set_wait_time(3)
			$Timer.start()
		1:
			_instaniate_enemy_b(725,250,15,.5,300,3,Vector2(-1,1))
			$Timer.set_wait_time(3)
			$Timer.start()
		2:
			_instaniate_enemy_b(350,250,10,.5,300,5,Vector2(-1,0))
			_instaniate_enemy_b(650,250,10,.5,300,5,Vector2(1,0))
			$Timer.set_wait_time(5)
			$Timer.start()
		3:
			_instaniate_enemy_a(500,300,40,10,400,5,Vector2(1,0))
			$Timer.set_wait_time(6)
			$Timer.start()
		4:
			_instaniate_enemy_b(350,300,5,.5,400,5,Vector2(1,1))
			$Timer.set_wait_time(.5)
			$Timer.start()
		5:
			_instaniate_enemy_b(425,300,5,.5,400,5,Vector2(1,1))
			$Timer.set_wait_time(.5)
			$Timer.start()
		6:
			_instaniate_enemy_b(500,300,5,.5,400,5,Vector2(0,1))
			$Timer.set_wait_time(.5)
			$Timer.start()
		7:
			_instaniate_enemy_b(575,300,5,.5,400,5,Vector2(-1,1))
			$Timer.set_wait_time(.5)
			$Timer.start()
		8:
			_instaniate_enemy_b(650,300,5,.5,400,5,Vector2(-1,1))
			$Timer.set_wait_time(7)
			$Timer.start()
		9:
			_instaniate_enemy_a(275,400,15,4,400,7.5,Vector2(1,1))
			$Timer.set_wait_time(1)
			$Timer.start()
		10:
			_instaniate_enemy_a(725,300,15,4,400,7.5,Vector2(-1,1))
			$Timer.set_wait_time(8)
			$Timer.start()
		11:
			_instaniate_enemy_a(500,400,25,15,400,5,Vector2(0,-1))
			$Timer.set_wait_time(6)
			$Timer.start()
		12:
			_instaniate_enemy_a(275,200,10,5,400,5,Vector2(0,-1))
			_instaniate_enemy_a(725,200,10,5,400,6,Vector2(0,-1))
			_instaniate_enemy_b(500,200,5,.3,400,7,Vector2(0,-1))
			$Timer.set_wait_time(8)
			$Timer.start()
		13:
			pass
		14:
			pass
		15:
			pass
		16:
			pass
		17:
			pass
		18:
			pass
		19:
			pass
		20:
			pass
	
	wave += 1
