extends Node

var GAME
var POINTER
var object_selected = null
signal new_build_created()
signal on_select_object(object)

var data = {
	"resources": 10
}

func _ready():
	pass

func select_object(object):
	object_selected = object
	emit_signal("on_select_object",object_selected)

func add_resource(cnt=0):
	data.resources += cnt
	GAME.get_node("UI").update_ui()

func add_float_text(tx,pos):
	var FX = preload("res://fx/FloatText.tscn").instance()
	FX.position = pos
	FX.setText(tx)
	GAME.add_child(FX)

func get_current_build_type():
	var b = GC.object_selected 
	if !b: return "NONE"
	if !"buildType" in b: return "NONE"
	return b.buildType
	
func set_z_index_to(obj):
	obj.z_index = 100+floor(obj.position.y/10)
