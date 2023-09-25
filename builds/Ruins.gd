extends "res://builds/_BasicBuild.gd"

func init():
	buildType = "RUINS"
	isEnabled = true
	GC.RESOURCE_NODES.append(self)

func set_enabled(val):
	isEnabled = val
	visible = isEnabled
