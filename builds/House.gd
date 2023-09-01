extends "res://builds/_BasicBuild.gd"

func init():
	buildType = "HOUSE"
	team = 1
	GC.add_one_resource("p",2)
	$healthComponent.connect("dead",self,"on_dead")

func on_dead(hc):
	GC.add_one_resource("p",-2)
