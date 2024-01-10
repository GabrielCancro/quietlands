extends StaticBody2D

var buildType = "NONE"
var isEnabled = false #to check if this site is interactable
var isBuilded = false #to check if has an building in it
var inPlace = null #to get reference base emplacement on destroy current
var team = -1

func _ready():
	init()
	GC.set_z_index_to(self)
	yield(get_tree().create_timer(.1),"timeout")
	var hc = get_node_or_null("healthComponent")
	if hc: hc.connect("dead",self,"_on_dead_superclass")
	#(GC.TILEMAP as TileMap).set_cell( floor(position.x/GC.TILEMAP.cell_size.x), floor(position.y/GC.TILEMAP.cell_size.y), 0)

func init():
	pass

func set_enabled(val):
	isEnabled = val
	if val: 
		GC.EFFECTOR.shine(global_position)
		GC.clear_fog_range(global_position/32,1,false)

func _on_dead_superclass(target):
	GC.destroy_structure(self)
