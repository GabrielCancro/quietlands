extends Area2D

var current_place
signal on_change_current_place(new_place)

func _ready():
	GC.PLAYER_BUILDER = self
	connect("body_entered",self,"check_places")
	connect("body_exited",self,"check_places")
	$Label.visible = false

func _process(delta):
	position = GC.PLAYER.position

func check_places(body):
	current_place = null
	if !GC.DAYNIGHT.isNight:
		for place in get_overlapping_bodies():
			if "buildType" in place && place.isEnabled:
				#if "isBuilded" in place && place.isBuilded: continue
				current_place = place
				break
#	if(current_place):
#		$Label.text = current_place.name
#		$Label.visible = true
#	else:
#		$Label.visible = false
	if current_place: print("check_places!!! ",current_place.name)
	emit_signal("on_change_current_place",current_place)
	#GC.RES_POPUP.set_popup(current_place)

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_F: 
			#UnitsFactory.spawn_bullet(get_global_mouse_position(),GC.PLAYER)
			UnitsFactory.spawn_unit("MILICIAN",get_global_mouse_position())
		if event.scancode == KEY_G: 
			UnitsFactory.spawn_unit("ENEMY",get_global_mouse_position())
		if event.scancode == KEY_P: 
			GC.DAYNIGHT.start_day()
