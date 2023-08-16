extends Control

func _ready():
	$btn1.connect("button_down",self,"on_build_button",["HOUSE"])
	$btn2.connect("button_down",self,"on_build_button",["BARRACK"])
	$btnX.connect("button_down",self,"hide_menu")

func show_menu():
	$btn1.set_data("HOUSE")
	$btn2.set_data("BARRACK")
	visible = true

func hide_menu():
	visible = false

func on_build_button(buildType):
	print("BUTTON CLICK "+str(buildType))
	var cost = BuildsFactory.BuildCosts[buildType]
	if GC.check_resorces_amount(cost):
		GC.reduce_resources(cost)
		BuildsFactory.Build_in_current_place(buildType)
		hide_menu()

func _input(event):
	if event.is_action_pressed("ui_cancel"): hide_menu()
