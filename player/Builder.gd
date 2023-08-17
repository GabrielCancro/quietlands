extends Area2D

var current_place
signal on_change_current_place(new_place)

func _ready():
	GC.PLAYER_BUILDER = self
	connect("body_entered",self,"check_places")
	connect("body_exited",self,"check_places")
	$Label.visible = false

func check_places(body):
	print("check_places!!!")
	current_place = null
	for place in get_overlapping_bodies():
		if "buildType" in place:
			current_place = place
			break
	if(current_place):
		$Label.text = current_place.name
		$Label.visible = true
	else:
		$Label.visible = false
	emit_signal("on_change_current_place",current_place)
	GC.RES_POPUP.set_popup(current_place)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if(current_place && current_place.has_method("interact")): current_place.interact()
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_G: 
			UnitsFactory.spawn_bullet(get_global_mouse_position(),GC.PLAYER)
