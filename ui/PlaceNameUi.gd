extends Control

func _ready():
	GC.PLAYER_BUILDER.connect("on_change_current_place",self,"on_change_current_place")

func on_change_current_place(node):
	if node && node.buildType: 
		$Label.text = node.buildType
		visible = true
	else:
		visible = false
