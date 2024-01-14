extends "res://builds/_BasicBuild.gd"

func init():
	buildType = "CASTLE"
	team = 1
	GC.clear_fog_range(global_position/32,5)
	GC.add_one_resource("p",2)
	GC.add_one_resource("xf",1)
	GC.add_one_resource("xw",1)
	
func on_dead(hc):
	GC.add_one_resource("p",-2)
	GC.add_one_resource("xf",-1)
	GC.add_one_resource("xw",-1)
