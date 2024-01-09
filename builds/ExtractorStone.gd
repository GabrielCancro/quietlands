extends "res://builds/_BasicBuild.gd"

func init():
	buildType = "EX_STONE"
	team = 1

func on_collect_phase():
	GC.collect_one_resource("s",global_position)
	GC.collect_one_resource("s",global_position,.2)

func on_dead(hc):
	BuildsFactory.Build("STONE",position)
