extends Control

func _ready():
	GC.GAME = self
	GC.WORLD = $World
	#$Camera2D/CenterPointer.connect("change_over_object",$UI,"on_pointer_change")
	#$Pointer.connect("change_over_object",$UI,"on_pointer_change")
	GC.connect("on_select_object",$UI,"on_select_object")
	#$World/TileFog.visible = true
	BuildsFactory.ExludesBuilds = []	
	load_level()

func load_level():
	var LEVEL = load("res://levels/level_"+str(GC.CURRENT_LEVEL)+".tscn").instance()
	add_child(LEVEL)
	GC.TILEMAP = LEVEL.get_node("TileMap")
	LEVEL.remove_child(GC.TILEMAP)
	GC.PLAYER.position = LEVEL.get_node("StartPosition").position
	LEVEL.get_node("StartPosition").queue_free()
	GC.WORLD.add_child(GC.TILEMAP)
	#GC.active_near_builds(GC.PLAYER)
	GC.clear_fog_range(GC.PLAYER.position/32,4)

var shifted = false
func _input(event):
	if event is InputEventKey && event.pressed && event.scancode == KEY_SHIFT && !shifted: 
		shifted=true
		print("""CHEATS
		M milician
		E enemy
		D force day
		W win game""")
	if event is InputEventKey && !event.pressed && event.scancode == KEY_SHIFT && shifted: shifted=false
	if event is InputEventKey && event.pressed && shifted:
		if event.scancode == KEY_M: 
			#UnitsFactory.spawn_bullet(get_global_mouse_position(),GC.PLAYER)
			UnitsFactory.spawn_unit("MILICIAN",get_global_mouse_position())
		if event.scancode == KEY_E: 
			UnitsFactory.spawn_unit("ENEMY",get_global_mouse_position())
		if event.scancode == KEY_D: 
			GC.DAYNIGHT.start_day()
		if event.scancode == KEY_W: 
			GC.end_game(true)
