extends Control

const level_influence_distance = 200

func _ready():
	set_level_states()
	$btn_back.connect("button_down",self,"on_back")

func set_level_states():
	#Add disabled levels to GC.LEVELS dictionari if is necessary
	for lv_node in $Levels.get_children(): if !lv_node.name in GC.LEVELS.keys(): GC.LEVELS[lv_node.name] = GC.LevelState.DISABLED

	_activate_levels_to_distance()
	_activate_levels_to_distance()

	for lv_node in $Levels.get_children():
		(lv_node as Button).focus_mode = Button.FOCUS_NONE
		(lv_node as Button).connect("button_down",self,"on_click",[lv_node])
		var index = lv_node.get_index()+1
		var name = lv_node.name
		var light = (lv_node.get_node("LIGHT1") as Light2D)
		var sprite = (lv_node.get_node("Sprite") as Sprite)
		sprite.texture = preload("res://assets/fog.png")
		light.color = Color(.01,.01,.01,1)
		if name in GC.LEVELS.keys():
			if GC.LEVELS[name] == GC.LevelState.DISCOVERED:
				sprite.texture = preload("res://assets/Elements/obj_dark_cristal_small.png")
				sprite.modulate = Color(.2,.2,.2,1)
				light.color = Color(.8,0,0,1)
			elif GC.LEVELS[name] == GC.LevelState.TOPLAY:
				sprite.texture = preload("res://assets/Elements/obj_dark_cristal_small.png")
				light.color = Color(1,0,0,1)
			elif GC.LEVELS[name] == GC.LevelState.WINNED:
				sprite.texture = preload("res://assets/Elements/bld_house_2.png")
				light.color = Color(.5,.5,.5,1)

func _activate_levels_to_distance():
	#check all winned levels and set some closed
	for lv_node in $Levels.get_children():
		if GC.LEVELS[lv_node.name]==GC.LevelState.WINNED or GC.LEVELS[lv_node.name]==GC.LevelState.TOPLAY: continue
		for lv_node2 in $Levels.get_children():
			if lv_node.rect_position.distance_to(lv_node2.rect_position) < level_influence_distance:
				if GC.LEVELS[lv_node2.name]==GC.LevelState.TOPLAY: GC.LEVELS[lv_node.name] = GC.LevelState.DISCOVERED
				if GC.LEVELS[lv_node2.name]==GC.LevelState.WINNED: GC.LEVELS[lv_node.name] = GC.LevelState.TOPLAY


func on_click(lv_node):
	print("CLICK ON ",lv_node.name," ",GC.LevelState.keys()[ GC.LEVELS[lv_node.name] ] )
	if GC.LEVELS[lv_node.name] == GC.LevelState.TOPLAY:
		GC.CURRENT_LEVEL = lv_node.get_index()+1
		get_tree().change_scene("res://scenes/Game.tscn")

func on_back():
	get_tree().change_scene("res://scenes/Menu.tscn")
