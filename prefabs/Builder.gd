extends Node2D

var min_array = []
var max_array = []
var buildeable = false

func _ready():
	visible = false
	$MinArea2D.connect("area_entered",self,"on_min_area_enter")
	$MinArea2D.connect("area_exited",self,"on_min_area_exit")
	$MaxArea2D.connect("area_entered",self,"on_max_area_enter")
	$MaxArea2D.connect("area_exited",self,"on_max_area_exit")

func on_min_area_enter(body):
	var node = body.get_parent()
	if "isBuildBlocker" in node && node.isBuildBlocker:
		min_array.append(node)
		check_buildeable()

func on_min_area_exit(body):
	var node = body.get_parent()
	if "isBuildBlocker" in node && node.isBuildBlocker:
		min_array.erase(node)
		check_buildeable()

func on_max_area_enter(body):
	var node = body.get_parent()
	if "isBuildBlocker" in node && node.isBuildBlocker:
		max_array.append(node)
		check_buildeable()

func on_max_area_exit(body):
	var node = body.get_parent()
	if "isBuildBlocker" in node && node.isBuildBlocker:
		max_array.erase(node)
		check_buildeable()

func check_buildeable():
	buildeable = false
	$Label.text = ""
	if min_array.size()>0: 
		$Label.text = "Muy Cerca"
	elif max_array.size()<=0: 
		$Label.text = "Muy Lejos"
	else: buildeable = true
	if buildeable: modulate = Color(.5,.5,1,1)
	else: modulate = Color(1,.5,.5,1)

func on_build_button_click():
	visible = !visible
