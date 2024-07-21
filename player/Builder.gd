extends Area2D

var current_place
signal on_change_current_place(new_place)

func _ready():
	GC.PLAYER_BUILDER = self
	connect("body_entered",self,"check_places")
	connect("body_exited",self,"check_places")

func _process(delta):
	position = GC.PLAYER.position
	$Sprite.visible = is_instance_valid(current_place)
	if($Sprite.visible):
		$Sprite.global_position = current_place.global_position
		$Sprite.z_index = current_place.z_index-10
		var hc = current_place.get_node_or_null("healthComponent")
		if hc: hc.show_healthbar()

func check_places(body):
	current_place = null
	if !GC.DAYNIGHT.isNight:
		for place in get_overlapping_bodies():
			if "buildType" in place && place.isEnabled:
				#if "isBuilded" in place && place.isBuilded: continue
				current_place = place
				break
#	if current_place: print("check_places!!! ",current_place.name)
	emit_signal("on_change_current_place",current_place)
	if !current_place: GC.HELPTEXT.unset_text()
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
