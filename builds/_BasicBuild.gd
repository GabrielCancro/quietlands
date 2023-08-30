extends StaticBody2D

var buildType = "NONE"
var isEnabled = true
var inPlace = null
var team = -1

func _ready():
	init()
	GC.set_z_index_to(self)

func init():
	pass
	
func set_enabled(val):
	isEnabled = val
