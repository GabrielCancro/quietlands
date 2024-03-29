extends "res://builds/_BasicBuild.gd"

func init():
	buildType = "ZIGURAT"
	isEnabled = false
	team = 2
	GC.DARK_CRISTAL_COUNTER += 1
	$healthComponent.connect("dead",self,"on_dead")

func on_dead(healtComponent):
	GC.DARK_CRISTAL_COUNTER -= 1
	if GC.DARK_CRISTAL_COUNTER == 0:
		GC.end_game(true)
