extends Node2D

var tuto_state = 0

func _ready():
	$Enemies/Portal.spawn_list = [
		{"day":1, "type":"I", "step":2, "enemy":"GHOST"},
		{"day":3, "type":"I", "step":3, "enemy":"GHOST"},
		{"day":6, "type":"I", "step":4, "enemy":"GHOST"},
	]
	
	BuildsFactory.connect("build_one",self,"on_build")
	yield(get_tree().create_timer(1),"timeout")
	GC.show_popup("tuto_01")
	yield(GC.POPUP,"close_popup")
	GC.show_popup("tuto_02")

func on_build(node): 
	if tuto_state==0: #SETTLEMENT
		tuto_state = 1
		yield(get_tree().create_timer(2),"timeout")
		GC.show_popup("tuto_03")
