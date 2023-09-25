extends "res://builds/_BasicBuild.gd"

export(String, "FOOD", "WOOD", "STONE") var RESOURCE_TYPE

func init():
	buildType = RESOURCE_TYPE
	isEnabled = true
	GC.RESOURCE_NODES.append(self)

func interact():
	pass

func set_enabled(val):
	isEnabled = val
