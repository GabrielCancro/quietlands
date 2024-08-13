extends Node2D


func _ready():
	$Enemies/Portal.spawn_list = [  
		{"day":2, "type":"I", "step":2, "enemy":"GHOST"}
	]
	yield(get_tree().create_timer(3),"timeout")
	GC.show_popup("start_level_2")
