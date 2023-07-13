extends StaticBody2D

var buildType = null #HOUSE BARRACK ARCHERY
var isBuildBlocker = true
var units_array = []

func _ready():
	if !buildType: set_build_type("HOUSE")
	yield(get_tree().create_timer(.1),"timeout")
	GC.emit_signal("new_build_created",self)
	$ProgressBar.connect("end_progress",self,"on_finish_progress")

func set_build_type(_buildType="NONE"):
	buildType = _buildType
	GC.set_z_index_to(self)
	if buildType=="HOUSE":
		$ProgressBar.set_time(5)
		$Sprite.frame = 30
	elif buildType=="BARRACK":
		$ProgressBar.set_time(5)
		$Sprite.frame = 29
	elif buildType=="ARCHERY":
		$ProgressBar.set_time(5)
		$Sprite.frame = 28

func on_finish_progress():
	if buildType=="HOUSE":
		GC.add_resource(3)
		GC.add_float_text(3,position+Vector2(0,-50))
	elif buildType=="BARRACK":
		create_unit("MILICIAN")
	elif buildType=="ARCHERY":
		GC.add_float_text("A",position+Vector2(0,-50))

func create_unit(unitType):
	var UNIT = preload("res://prefabs/Unit.tscn").instance()
	UNIT.set_unit(self,unitType)
	GC.GAME.add_child(UNIT)
	units_array.append(UNIT)
	UNIT.connect("dead",self,"on_unit_dead")
	if(units_array.size()>=GC.CONFIG.units_per_barrack):
		$ProgressBar.set_active(false)

func on_unit_dead(unit):
	units_array.remove(unit)
	if(units_array.size()<GC.CONFIG.units_per_barrack):
		$ProgressBar.set_active(true)
