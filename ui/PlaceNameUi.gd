extends Control

func _ready():
	GC.PLAYER_BUILDER.connect("on_change_current_place",self,"on_change_current_place")

func on_change_current_place(node):
	if node && node.buildType: 
		$Label.text = Lang.get_localization("bld_name_"+node.buildType)
		if "amount" in node: $Label.text += " ("+str(node.amount)+")"
		visible = true
	else:
		visible = false
