extends "res://builds/_BasicBuild.gd"

func init():
	buildType = "EXT_WOOD"
	team = 1

func on_collect_phase():
	GC.collect_one_resource("w",global_position)
	GC.collect_one_resource("w",global_position,.2)
