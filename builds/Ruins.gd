extends "res://builds/_BasicBuild.gd"

func init():
	buildType = "RUINS"
	GC.RESOURCE_NODES.append(self)
	set_enabled(false)

func set_enabled(val):
	.set_enabled(val)
	modulate = Color(.5,.3,.3,1)
	if isEnabled: modulate = Color(1,1,1,1)
