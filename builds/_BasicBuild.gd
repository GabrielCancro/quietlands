extends StaticBody2D

var buildType = "NONE"
var isEnabled = true
var inPlace = null
var team = -1

func _ready():
	init()
	GC.set_z_index_to(self)
	yield(get_tree().create_timer(.1),"timeout")
	(GC.TILEMAP as TileMap).set_cell( floor(position.x/GC.TILEMAP.cell_size.x), floor(position.y/GC.TILEMAP.cell_size.y), 1)

func init():
	pass

func set_enabled(val):
	isEnabled = val
