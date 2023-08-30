extends "res://builds/_BasicBuild.gd"

func init():
	buildType = "ZIGURAT"
	isEnabled = false
	team = 2
	GC.ZIGURATS_COUNTER += 1
	$healthComponent.connect("dead",self,"on_dead")

func on_dead(healtComponent):
	GC.ZIGURATS_COUNTER -= 1
	if GC.ZIGURATS_COUNTER == 0:
		print("WIN!!!")
