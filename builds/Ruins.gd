extends "res://builds/_BasicBuild.gd"

func init():
	buildType = "RUINS"
	isEnabled = true

func set_enabled(val):
	isEnabled = val
	visible = isEnabled
