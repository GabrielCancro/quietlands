extends "res://prefabs/builds/BuildBase.gd"

func _ready():
	buildType = GC.BuildEnum.BARRACK
	own = GC.OwnEnum.PLAYER
	$ProgressBar.set_time(5)

func on_finish_progress():
	spawn_unit(GC.UnitEnum.MILICIAN)
