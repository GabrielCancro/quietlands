extends Node

var GAME
var UI
var DAYNIGHT
var POINTER
var PLAYER
var CAMERA
var PLAYER_BUILDER
var WORLD
var TILEMAP
var RES_POPUP
var EFFECTOR
var HEALTHS = []
var RESOURCE_NODES = [] # resources and ruins nodes of map
var ENEMIES_FROM_PORTAL = 0
var TOTAL_SOLDIERS = 0
var DARK_CRISTAL_COUNTER = 0
var object_selected = null
var RES = {"f":5, "w":5, "s":5, "p":0, "xf":0, "xw":0, "xs":0}

signal new_build_created()
signal on_select_object(object)

enum OwnEnum {NONE,PLAYER,ENEMY}
enum BuildEnum {DEBRIS,HOUSE,BARRACK,ARCHERY,RESOURCE}
enum UnitEnum {MILICIAN,ARCHER}

var CONFIG = {
	"units_per_barrack":3,
}

var data = {
	"resources": 10
}

func _ready():
	pass

func select_object(object):
	object_selected = object
	emit_signal("on_select_object",object_selected)

func add_one_resource(key,val):
	RES[key] += val
	GAME.get_node("UI").update_ui()

func reduce_resources(cost={}):
	for k in cost.keys():
		RES[k] -= cost[k]
	GAME.get_node("UI").update_ui()

func check_resorces_amount(cost={}):
	for k in cost.keys():
		if RES[k]<cost[k]: return false
	return true

func add_float_text(tx,pos):
	var FX = preload("res://fx/FloatText.tscn").instance()
	FX.position = pos
	FX.setText(tx)
	GAME.add_child(FX)

func get_current_build_type():
	var b = GC.object_selected 
	if !b: return -1
	if !"buildType" in b: return -1
	return b.buildType
	
func set_z_index_to(obj,offset=0):
	obj.z_index = 100+floor(obj.position.y/5)+offset

func clear_fog(pos,rad):
	pass
#	if rad<=0: return;
#	pos = Vector2(floor(pos.x/32),floor(pos.y/32))
#	var Tile = GAME.get_node("World/TileFog") as TileMap
#	for ix in range(-rad,rad+1):
#		for iy in range(-rad,rad+1):
#			if(abs(ix)+abs(iy)>rad+1): continue
#			Tile.set_cell(pos.x+ix,pos.y+iy,-1)
#			print( str(pos)+"  "+str( Tile.get_cell(pos.x+ix,pos.y+iy) ) )

func get_bbcode_cost(cost):
	var bbcode = "[center]"
	bbcode += get_resource_string_bbcode_formated(cost,"f")+" / "
	bbcode += get_resource_string_bbcode_formated(cost,"w")+" / "
	bbcode += get_resource_string_bbcode_formated(cost,"s")
	return bbcode

func get_resource_string_bbcode_formated(cost,key):
	var bbcode = ""
	if !key in cost: bbcode += "-"
	elif RES[key]>=cost[key]: bbcode += str(cost[key])
	else: bbcode += "[color=red]"+str(cost[key])+"[/color]"
	return bbcode

func get_most_close_health(my,distance=99999):
	var candidate = null
	for un in GC.HEALTHS:
		if !is_instance_valid(un): continue
		if "team" in my && my.team != -1 && "team" in un && un.team==my.team: continue
		if my.position.distance_to(un.position)>distance: continue
		distance = my.position.distance_to(un.position)
		candidate = un
	return candidate

func collect_resources():
	for r in range(RES["xf"]): 
		collect_one_resource("f")
		yield(get_tree().create_timer(.2),"timeout")
	for r in range(RES["xw"]): 
		collect_one_resource("w")
		yield(get_tree().create_timer(.2),"timeout")
	for r in range(RES["xs"]): 
		collect_one_resource("s")
		yield(get_tree().create_timer(.2),"timeout")
	
#	for bld in BuildsFactory.BUILDINGS:
#		if !is_instance_valid(bld): continue
#		if bld.has_method("on_collect_phase"): bld.on_collect_phase()
#
#	yield(get_tree().create_timer(2),"timeout")
#	var dl = 0
#	for un in UnitsFactory.UNITS:
#		if RES["f"]<=-5: break
#		if !is_instance_valid(un): continue
#		if un.team==1: 
#			consume_one_resource("f",dl)
#			dl += .2
		
#		if bld.buildType == "EXTRACTOR":
#			change_camera_follow(bld)
#			yield(get_tree().create_timer(.5),"timeout")
#			for i in range(bld.amount_res):
#				recollect_one_resource_ui( bld.extractor_type.substr(0,1).to_lower() )
#				yield(get_tree().create_timer(.5),"timeout")
#				bld.inPlace.amount -= 1
#			print(bld.inPlace.name+" le queda: "+str(bld.inPlace.amount))
#			if(bld.inPlace.amount<=0):
#				destroy_structure(bld)
#				yield(get_tree().create_timer(1),"timeout")
#		elif bld.buildType == "CASTLE":
#				change_camera_follow(bld)
#				yield(get_tree().create_timer(.5),"timeout")
#				recollect_one_resource_ui( "f" )
#				yield(get_tree().create_timer(.5),"timeout")
#				recollect_one_resource_ui( "w" )
#				yield(get_tree().create_timer(.5),"timeout")
#		change_camera_follow(GC.PLAYER)

func end_game(win=true):
	get_tree().paused = true
	for i in UI.get_children():
		i.visible = false
		if i.name=="EndGamePanel": 
			i.visible = true
			if win==false: UI.get_node("EndGamePanel/Button/Label").text = "HAS MUERTO"

func active_near_builds(Build):
	for b in RESOURCE_NODES:
		if !is_instance_valid(b):
			RESOURCE_NODES.erase(b)
			continue
		if(b.global_position.distance_to(Build.global_position)<120):
			if !b.isEnabled: b.set_enabled(true)

func change_camera_follow(node):
	CAMERA.global_position = node.global_position 

#func recollect_one_resource_ui(type):
#	var Node = preload("res://ui/ResourceCollectedEffect.tscn").instance()
#	Node.set_resource( type )
#	UI.add_child(Node)

func collect_one_resource(type):
	var Node = preload("res://ui/ResourceCollectedEffect.tscn").instance()
	Node.set_resource( type )
	UI.add_child(Node)

func destroy_structure(structure):
	if "inPlace" in structure && structure.inPlace:
		BuildsFactory.Build(structure.inPlace,structure.position)
	HEALTHS.erase(structure)
	BuildsFactory.BUILDINGS.erase(structure)
	#(TILEMAP as TileMap).set_cell( floor(structure.position.x/TILEMAP.cell_size.x), floor(structure.position.y/TILEMAP.cell_size.y), 0)
	structure.queue_free()
	EFFECTOR.shine(structure.global_position)

func clear_fog_range(pos,ran,enableBuilds = true):
	var fogMap = (GAME.get_node("World/FogTileMap") as TileMap)
	fogMap.set_cell(pos.x,pos.y,-1)
	for _x in range(-ran,ran+1):
		for _y in range(-ran,ran+1):
			if Vector2(_x,_y).distance_to(Vector2.ZERO)>ran: continue
			fogMap.set_cell(pos.x+_x,pos.y+_y,-1)
	#ACTIVE BUILDS
	if enableBuilds:
		for b in RESOURCE_NODES:
			if !is_instance_valid(b):
				RESOURCE_NODES.erase(b)
				continue
			if(b.global_position.distance_to(pos*32)<(ran*32)+1):
				if !b.isEnabled: b.set_enabled(true)

