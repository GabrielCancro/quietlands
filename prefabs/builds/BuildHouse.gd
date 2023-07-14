extends "res://prefabs/builds/BuildBase.gd"

func _ready():
	buildType = GC.BuildEnum.HOUSE
	own = GC.OwnEnum.PLAYER
	$ProgressBar.set_time(5)

func on_finish_progress():
	GC.add_resource(3)
	GC.add_float_text(3,position+Vector2(0,-50))
