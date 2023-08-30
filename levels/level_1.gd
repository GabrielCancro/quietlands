extends Node2D

func _ready():
	GC.NAV2D = $Navigation2D
	pass
#	for t in $Deco.get_children():
#		GC.set_z_index_to(t)
#	for s in $Structures.get_children():
#		GC.set_z_index_to(s)
