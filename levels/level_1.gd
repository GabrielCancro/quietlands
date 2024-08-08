extends Node2D

var tuto_state = 0

func _ready():
	BuildsFactory.connect("build_one",self,"on_build")
	UnitsFactory.connect("train_one",self,"on_train")
	BuildsFactory.ExludesBuilds = BuildsFactory.BuildCosts.keys()
	BuildsFactory.ExludesBuilds.erase("SETTLEMENT")
	yield(get_tree().create_timer(3),"timeout")
	GC.show_popup("tuto_01")
	yield(GC.POPUP,"close_popup")
	GC.show_popup("tuto_02")
	yield(GC.POPUP,"close_popup")
	GC.OBJETIVETEXT.set_text("tuto_obj_01")

func on_build(node): 
	if tuto_state==0 && node.buildType=="SETTLEMENT": #SETTLEMENT
		yield(get_tree().create_timer(2),"timeout")
		tuto_state = 1
		GC.OBJETIVETEXT.unset_text()
		GC.show_popup("tuto_03")
		yield(GC.POPUP,"close_popup")
		GC.show_popup("tuto_04")
		yield(GC.POPUP,"close_popup")
		GC.OBJETIVETEXT.set_text("tuto_obj_02")
		BuildsFactory.ExludesBuilds.append("SETTLEMENT")
		BuildsFactory.ExludesBuilds.erase("EXT_WOOD")
		BuildsFactory.ExludesBuilds.erase("EXT_FOOD")
		BuildsFactory.ExludesBuilds.erase("EXT_STONE")
		BuildsFactory.ExludesBuilds.erase("OUTPOST")
	if tuto_state==1 && node.buildType=="EXT_WOOD":
		yield(get_tree().create_timer(2),"timeout")
		GC.OBJETIVETEXT.unset_text()
		GC.show_popup("tuto_04b")
		yield(GC.POPUP,"close_popup")
		yield(get_tree().create_timer(2),"timeout")
		tuto_state = 2
		GC.show_popup("tuto_05")
		yield(GC.POPUP,"close_popup")
		GC.show_popup("tuto_06")
		yield(GC.POPUP,"close_popup")
		GC.OBJETIVETEXT.set_text("tuto_obj_03")
		BuildsFactory.ExludesBuilds.erase("HOUSE")
		BuildsFactory.ExludesBuilds.erase("BARRACK")

func on_train(unitNode):
	if unitNode.unitType=="MILICIAN": tuto_state += 1
	print("UNIT ",unitNode.unitType," ST",tuto_state)
	if tuto_state >= 4:
		GC.OBJETIVETEXT.unset_text()
		yield(get_tree().create_timer(2),"timeout")
		GC.show_popup("tuto_07")
		yield(GC.POPUP,"close_popup")
		yield(get_tree().create_timer(2),"timeout")
		GC.end_game(true)
	
