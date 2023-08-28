extends StaticBody2D

export var buildType = "NONE"
var isEnabled = true
var inPlace = null

func _ready():
	GC.set_z_index_to(self)

func interact():
	pass

func set_enabled(val):
	isEnabled = val
