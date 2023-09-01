extends "res://builds/_BasicBuild.gd"

var endSpawnWave = false
var spawn_list = [  #Types A:ACUMULATIVE / S:SPECIFIC / I:INCREMENTAL
#	{"day":1, "type":"I", "step":2, "enemy":"GHOST"},
#	{"day":2, "type":"I", "step":3, "enemy":"GHOST"},
#	{"day":3, "type":"I", "step":4, "enemy":"GHOST"},
]

func init():
	buildType = "PORTAL"
	isEnabled = false
	team = 2
	setActivated(false)
	yield(get_tree().create_timer(.1),"timeout")
	GC.DAYNIGHT.connect("change_time",self,"on_change_night")

func on_change_night(day, isNight):
	setActivated(isNight)
	if isNight:
		start_wave(day)

func setActivated(val):
	$AnimatedSprite.visible = val
#	if val:
#		$AnimatedSprite.playing = true
#		$AnimatedSprite.modulate.a = 1
#	else:
#		$AnimatedSprite.modulate.a = .3

func spawn(enemy):
	var rnd_var = Vector2(rand_range(-1,1),rand_range(-1,1)).normalized()
	var NODE = UnitsFactory.spawn_unit("ENEMY",position+rnd_var*20)
	NODE.get_node("healthComponent").connect("dead",self,"on_dead_enemy")
	GC.ENEMIES_FROM_PORTAL += 1

func on_dead_enemy(healthComponent):
	GC.ENEMIES_FROM_PORTAL -= 1
	if endSpawnWave && GC.ENEMIES_FROM_PORTAL==0: 
		yield(get_tree().create_timer(1),"timeout")
		GC.DAYNIGHT.start_day()

func start_wave(day):
	endSpawnWave = false
	for data in spawn_list:
		if data.day>day: break
		if data.day == day && data.type=="S": 
			yield(get_tree().create_timer(.4),"timeout")
			spawn(data.enemy)
		if data.day<=day && data.type=="A":
			yield(get_tree().create_timer(.4),"timeout")
			spawn(data.enemy)
		if data.day<=day && data.type=="I":
			for i in range(1+floor(day-data.day)/data.step):
				yield(get_tree().create_timer(.4),"timeout")
				spawn(data.enemy)
	endSpawnWave = true
