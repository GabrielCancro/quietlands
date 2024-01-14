extends "res://builds/_BasicBuild.gd"

func init():
	buildType = "EXT_WOOD"
	team = 1
	GC.add_one_resource("xw",2)

func on_dead():
	GC.add_one_resource("xw",-2)
