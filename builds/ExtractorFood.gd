extends "res://builds/_BasicBuild.gd"

func init():
	buildType = "EX_FOOD"
	team = 1

func on_collect_phase():
	GC.collect_one_resource("f",global_position)
	GC.collect_one_resource("f",global_position,.2)

func on_dead(hc):
	print("on_dead TO ", self.name, position)
	BuildsFactory.Build("FOOD",position)
