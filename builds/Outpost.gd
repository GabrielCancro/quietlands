extends "res://builds/_BasicBuild.gd"

func init():
	buildType = "OUTPOST"
	team = 1
	GC.clear_fog_range(global_position/32,4)
	$healthComponent.connect("dead",self,"on_dead")

func on_dead(hc):
	pass
