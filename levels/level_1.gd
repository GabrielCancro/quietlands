extends Node2D

func _ready():
	GC.NAV2D = $Navigation2D
	$Enemies/Portal.spawn_list = [
		{"day":1, "type":"I", "step":2, "enemy":"GHOST"},
		{"day":2, "type":"I", "step":3, "enemy":"GHOST"},
		{"day":3, "type":"I", "step":4, "enemy":"GHOST"},
	]
	pass
#	for t in $Deco.get_children():
#		GC.set_z_index_to(t)
#	for s in $Structures.get_children():
#		GC.set_z_index_to(s)
