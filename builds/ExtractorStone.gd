extends "res://builds/_BasicBuild.gd"

var amount = 0

func init():
	buildType = "EXT_STONE"
	team = 1
	GC.add_one_resource("xs",2)

func on_dead():
	inPlace.amount = amount
	GC.add_one_resource("xs",-2)
