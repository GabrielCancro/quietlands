extends Control

func _ready():
	randomize()
	modulate.a = 0
	yield(get_tree().create_timer(.1),"timeout")
	GC.EFFECTOR.appear_ui(self)
	for b in $Buttons.get_children(): b.connect("button_down",self,"on_click",[b])

func on_click(btn):
	var n = btn.name
	if n=="btn_start": get_tree().change_scene("res://scenes/Map.tscn")
	elif n=="btn_options": get_tree().change_scene("res://scenes/Menu.tscn")
	elif n=="btn_quit": get_tree().quit()
