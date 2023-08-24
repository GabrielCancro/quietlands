extends Node

var GAME
var UI
var DAYNIGHT
var POINTER
var PLAYER
var PLAYER_BUILDER
var RES_POPUP
var EFFECTOR
var HEALTHS = []
var ENEMIES_FROM_PORTAL = 0
var object_selected = null
var RES = {"f":5, "w":5, "s":5}

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
	obj.z_index = 100+floor(obj.position.y/10)+offset

func clear_fog(pos,rad):
	if rad<=0: return;
	pos = Vector2(floor(pos.x/32),floor(pos.y/32))
	var Tile = GAME.get_node("World/TileFog") as TileMap
	for ix in range(-rad,rad+1):
		for iy in range(-rad,rad+1):
			if(abs(ix)+abs(iy)>rad+1): continue
			Tile.set_cell(pos.x+ix,pos.y+iy,-1)
			print( str(pos)+"  "+str( Tile.get_cell(pos.x+ix,pos.y+iy) ) )

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
	for bld in GC.HEALTHS:
		if !is_instance_valid(bld): continue
		if !bld.get("buildType"): continue
		if bld.buildType != "EXTRACTOR": continue
		yield(get_tree().create_timer(.5),"timeout")
		var Node = preload("res://ui/ResourceCollectedEffect.tscn").instance()
		Node.set_resource( bld.extractor_type.substr(0,1).to_lower() )
		UI.add_child(Node)
