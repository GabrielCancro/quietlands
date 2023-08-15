extends Area2D

var current_place
signal on_change_current_place(new_place)

func _ready():
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

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if(current_place && current_place.has_method("interact")): current_place.interact()
