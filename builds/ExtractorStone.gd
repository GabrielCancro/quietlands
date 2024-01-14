extends "res://builds/_BasicBuild.gd"

func init():
	buildType = "EXT_STONE"
	team = 1
	GC.add_one_resource("xs",2)

func on_colleon_deadct_phase():
	GC.add_one_resource("xs",-2)
