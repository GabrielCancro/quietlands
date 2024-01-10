extends "res://builds/_BasicBuild.gd"

func init():
	buildType = "OUTPOST"
	team = 1
	$healthComponent.connect("dead",self,"on_dead")

func on_dead(hc):
	pass
