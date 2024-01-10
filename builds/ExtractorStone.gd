extends "res://builds/_BasicBuild.gd"

func init():
	buildType = "EXT_STONE"
	team = 1

func on_collect_phase():
	GC.collect_one_resource("s",global_position)
	GC.collect_one_resource("s",global_position,.2)
