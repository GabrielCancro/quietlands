extends "res://builds/_BasicBuild.gd"

export(String, "FOOD", "WOOD", "STONE") var RESOURCE_TYPE
export var amount = 5

func init():
	buildType = RESOURCE_TYPE
	GC.RESOURCE_NODES.append(self)
	set_enabled(false)

func interact():
	pass

func set_enabled(val):
	.set_enabled(val)
	modulate = Color(.5,.5,.5,.2)
	if isEnabled: modulate = Color(1,1,1,1)
