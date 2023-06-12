extends Node2D

var blocks_array = []

func _ready():
	visible = false
	$Area2D.connect("area_entered",self,"on_area_enter")
	$Area2D.connect("area_exited",self,"on_area_exit")

func on_area_enter(body):
	var node = body.get_parent()
	if "isBuildBlocker" in node && node.isBuildBlocker:
		print("ENTERED ")
		blocks_array.append(node)
	if blocks_array.size()>0: modulate = Color(1,0,0,1)
	else: modulate = Color(.5,.5,1,1)

func on_area_exit(body):
	var node = body.get_parent()
	if "isBuildBlocker" in node && node.isBuildBlocker:
		print("EXITED")
		blocks_array.erase(node)
	if blocks_array.size()>0: modulate = Color(1,0,0,1)
	else: modulate = Color(.5,.5,1,1)

func on_build_button_click():
	visible = !visible
