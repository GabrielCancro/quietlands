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
	$Sprite2.visible = $Sprite.visible
	if($Sprite.visible):
		$Sprite.global_position = current_place.global_position
		$Sprite2.global_position = current_place.global_position + Vector2(0,-7)
		if $Sprite2.texture && $Sprite2.texture.get_size().y>48: $Sprite2.global_position += Vector2(0,48-$Sprite2.texture.get_size().y)
		$Sprite.z_index = current_place.z_index-50
		$Sprite2.z_index = current_place.z_index+1
		var hc = current_place.get_node_or_null("healthComponent")
		if hc: hc.show_healthbar()

func check_places(body):
	current_place = null
	set_build_texture(null)
	if !GC.DAYNIGHT.isNight:
		for place in get_overlapping_bodies():
			if "buildType" in place && place.isEnabled:
				#if "isBuilded" in place && place.isBuilded: continue
				current_place = place
				#GC.HELPTEXT.set_text("desc_build_"+current_place.buildType)
				GC.HELPTEXT.unset_text()
				break
#	if current_place: print("check_places!!! ",current_place.name)
	emit_signal("on_change_current_place",current_place)
	if !current_place: GC.HELPTEXT.unset_text()
	#GC.RES_POPUP.set_popup(current_place)

func set_build_texture(name):
	#if name:
		#$Sprite2.texture = load("res://assets/Elements/bld_"+name.to_lower()+".png")
	#else:
		$Sprite2.texture = null
