extends Control

func _ready():
	$btn1.connect("button_down",self,"on_build_button",["HOUSE"])
	$btn2.connect("button_down",self,"on_build_button",[GC.BuildEnum.BARRACK])
	$btnX.connect("button_down",self,"hide_menu")

func show_menu():
	visible = true

func hide_menu():
	visible = false

func on_build_button(buildType):
	print("BUTTON CLICK "+str(buildType))
	BuildsFactory.Build_in_current_place(buildType)
	hide_menu()

func _input(event):
	if event.is_action_pressed("ui_cancel"): hide_menu()
