extends KinematicBody2D

var unitType
var team = 1

func _ready():
	$Weapon.connect("attack",self,"on_attack")
	if team==1: 
		GC.TOTAL_SOLDIERS += 1
		GC.add_one_resource("p",0)
		GC.add_one_resource("xf",-1)
		$healthComponent.connect("dead",self,"on_dead")

func _process(delta):
	pass

func on_attack(target):
	$IA_SoldierBasic.awaiting = 1

func on_dead(hc):
	GC.TOTAL_SOLDIERS -= 1
	GC.add_one_resource("p",0)
	GC.add_one_resource("xf",+1)
