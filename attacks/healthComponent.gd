extends Node2D

export var hpMax = 5
var hp
signal receive_damage(healthComponent)
signal dead(healthComponent)

func _ready():
	hp = hpMax
	GC.HEALTHS.append(get_parent())

func get_damage(dam=1):
	hp -= dam
	#print("DAM ",get_parent().name," ",hp,"/",hpMax)
	emit_signal("receive_damage",self)
	if(hp<0): 
		emit_signal("dead",self)
		get_parent().queue_free()
