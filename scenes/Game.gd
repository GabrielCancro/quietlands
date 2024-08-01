extends Node2D

func _ready():
	GC.GAME = self
	GC.WORLD = $World
	#$Camera2D/CenterPointer.connect("change_over_object",$UI,"on_pointer_change")
	#$Pointer.connect("change_over_object",$UI,"on_pointer_change")
	GC.connect("on_select_object",$UI,"on_select_object")
	#$World/TileFog.visible = true
	load_level(1)

func load_level(id):
	var LEVEL = load("res://levels/level_"+str(id)+".tscn").instance()
	add_child(LEVEL)
	GC.TILEMAP = LEVEL.get_node("TileMap")
	LEVEL.remove_child(GC.TILEMAP)
	GC.PLAYER.position = LEVEL.get_node("StartPosition").position
	LEVEL.get_node("StartPosition").queue_free()
	GC.WORLD.add_child(GC.TILEMAP)
	#GC.active_near_builds(GC.PLAYER)
	GC.clear_fog_range(GC.PLAYER.position/32,4)
