extends Control

func _ready():
	$btn1.connect("button_down",self,"on_build_button",[GC.BuildEnum.HOUSE])
	$btn2.connect("button_down",self,"on_build_button",[GC.BuildEnum.BARRACK])
	$btnX.connect("button_down",self,"hide_menu")

func show_menu():
	visible = true

func hide_menu():
	visible = false

func on_build_button(buildType):
	print("BUTTON CLICK "+str(buildType))

func on_build_extractor():
	GC.object_selected.build()

func get_build_scene(buildType):
	if buildType==GC.BuildEnum.HOUSE: return preload("res://prefabs/builds/BuildHouse.tscn").instance()
	if buildType==GC.BuildEnum.BARRACK: return preload("res://prefabs/builds/BuildBarrack.tscn").instance()

func _input(event):
	if event.is_action_pressed("ui_cancel"): hide_menu()
