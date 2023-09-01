extends Node2D

export var hpMax = 5
var hp
var dont_free_on_dead = false

var show_time = 0
signal receive_damage(healthComponent)
signal dead(healthComponent)

func _ready():
	hp = hpMax
	modulate.a = 0
	GC.HEALTHS.append(get_parent())
	GC.set_z_index_to(self)

func _process(delta):
	if show_time>0: show_time -= delta
	modulate.a = min(1,show_time*5)

func get_damage(dam=1):
	hp -= dam
	show_time = 2
	$TextureProgress.value = float(hp)/float(hpMax)*100
	#print("DAM ",get_parent().name," ",hp,"/",hpMax)
	emit_signal("receive_damage",self)
	if(hp<=0): 
		GC.EFFECTOR.dead_fx(global_position)
		emit_signal("dead",self)
		if !dont_free_on_dead: get_parent().queue_free()
