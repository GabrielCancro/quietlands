extends "res://builds/_BasicBuild.gd"

var amount = 0

func init():
	buildType = "EXT_WOOD"
	team = 1
	GC.add_one_resource("xw",2)

func on_dead():
	inPlace.amount = amount
	GC.add_one_resource("xw",-2)
