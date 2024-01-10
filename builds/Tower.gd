extends "res://builds/_BasicBuild.gd"

func init():
	buildType = "TOWER"
	inPlace = "DEBRIS"
	team = 1
	$healthComponent.connect("dead",self,"on_dead")

func on_dead(hc):
	pass
