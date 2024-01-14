extends "res://builds/_BasicBuild.gd"

func init():
	buildType = "EXT_FOOD"
	team = 1
	GC.add_one_resource("xf",2)

func on_dead():
	GC.add_one_resource("xf",-2)
