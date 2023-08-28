extends StaticBody2D

var buildType = "RUINS"
var isEnabled = true
var inPlace = null

func set_enabled(val):
	isEnabled = val
	visible = isEnabled
