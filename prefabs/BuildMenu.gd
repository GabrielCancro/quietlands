extends Control

func _ready():
	$btn1.connect("button_down",self,"on_build_button",[GC.BuildEnum.HOUSE])
	$btn2.connect("button_down",self,"on_build_button",[GC.BuildEnum.BARRACK])
	$btn3.connect("button_down",self,"on_build_button",[GC.BuildEnum.ARCHERY])

func on_build_button(buildType):
	var BUILD = get_build_scene(buildType)
	BUILD.position = GC.object_selected.position
	GC.GAME.add_child(BUILD)
	var old_object = GC.object_selected
	GC.select_object(BUILD)
	old_object.queue_free()

func get_build_scene(buildType):
	if buildType==GC.BuildEnum.HOUSE: return preload("res://prefabs/builds/BuildHouse.tscn").instance()
	if buildType==GC.BuildEnum.BARRACK: return preload("res://prefabs/builds/BuildBarrack.tscn").instance()
