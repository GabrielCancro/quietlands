extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$btn1.connect("button_down",self,"on_build_button",["HOUSE"])
	$btn2.connect("button_down",self,"on_build_button",["BARRACK"])
	$btn3.connect("button_down",self,"on_build_button",["ARCHERY"])

func on_build_button(buildType):
	print("BUILD AN "+buildType)
	var BUILD = preload("res://prefabs/Build.tscn").instance()
	BUILD.position = GC.object_selected.position
	BUILD.set_build_type(buildType)
	GC.GAME.add_child(BUILD)
	var old_object = GC.object_selected
	GC.select_object(BUILD)
	old_object.queue_free()
