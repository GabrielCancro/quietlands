extends Node

var GAME
var POINTER
var PLAYER
var UNITS = []
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
