extends "res://builds/_BasicBuild.gd"

func init():
	buildType = "CASTLE"
	team = 1
	GC.clear_fog_range(global_position/32,5)
	GC.add_one_resource("p",2)

func on_collect_phase():
	GC.collect_one_resource("f",global_position)
	GC.collect_one_resource("w",global_position,.2)
	
func on_dead(hc):
	GC.add_one_resource("p",-2)
