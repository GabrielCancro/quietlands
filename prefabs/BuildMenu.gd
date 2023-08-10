extends Control

func _ready():
	$BuildPanelDerbis/btn1.connect("button_down",self,"on_build_button",[GC.BuildEnum.HOUSE])
	$BuildPanelDerbis/btn2.connect("button_down",self,"on_build_button",[GC.BuildEnum.BARRACK])
	$btn_res.connect("button_down",self,"on_build_extractor")
	update_menu()

func update_menu(buildType=-1):
	var build = GC.object_selected
	$BuildPanelDerbis.visible = (buildType==GC.BuildEnum.DEBRIS && build.isActive)
	$btn_res.visible = (buildType==GC.BuildEnum.RESOURCE && build.isActive && !build.isBuilded)

func on_build_button(buildType):
	var BUILD = get_build_scene(buildType)
	BUILD.position = GC.object_selected.position
	GC.GAME.add_child(BUILD)
	var old_object = GC.object_selected
	GC.select_object(BUILD)
	old_object.queue_free()

func on_build_extractor():
	GC.object_selected.build()

func get_build_scene(buildType):
	if buildType==GC.BuildEnum.HOUSE: return preload("res://prefabs/builds/BuildHouse.tscn").instance()
	if buildType==GC.BuildEnum.BARRACK: return preload("res://prefabs/builds/BuildBarrack.tscn").instance()
