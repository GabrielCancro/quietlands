extends StaticBody2D

var buildType = "PORTAL"
var isEnabled = false
var inPlace = null
var endSpawnWave = false

func _ready():
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

func spawn():
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
	for i in range(1+day):
		yield(get_tree().create_timer(.4),"timeout")
		spawn()
	endSpawnWave = true
