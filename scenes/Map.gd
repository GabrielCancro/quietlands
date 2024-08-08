extends Control

func _ready():
	set_level_states()
	$btn_back.connect("button_down",self,"on_back")

func set_level_states():
	for lv_node in $Levels.get_children():
		(lv_node as Button).focus_mode = Button.FOCUS_NONE
		(lv_node as Button).connect("button_down",self,"on_click",[lv_node])
		var index = lv_node.get_index()+1
		var name = "L"+str(index)
		var light = (lv_node.get_node("LIGHT1") as Light2D)
		var sprite = (lv_node.get_node("Sprite") as Sprite)
		sprite.texture = null
		light.color = Color(.01,.01,.01,1)
		if name in GC.LEVELS.keys():
			if GC.LEVELS[name] == "discovered":
				sprite.texture = preload("res://assets/Elements/obj_dark_cristal_small.png")
				sprite.modulate = Color(.2,.2,.2,1)
				light.color = Color(.8,0,0,1)
			elif GC.LEVELS[name] == "toPlay":
				sprite.texture = preload("res://assets/Elements/obj_dark_cristal_small.png")
				light.color = Color(1,0,0,1)
			elif GC.LEVELS[name] == "winned":
				sprite.texture = preload("res://assets/Elements/bld_house_2.png")
				light.color = Color(.5,.5,.5,1)

func on_click(lv_node):
	print("CLICK ON ",lv_node.name)
	if GC.LEVELS[lv_node.name] == "toPlay":
		GC.CURRENT_LEVEL = lv_node.get_index()+1
		get_tree().change_scene("res://scenes/Game.tscn")

func on_back():
	get_tree().change_scene("res://scenes/Menu.tscn")
