extends StaticBody2D

var buildType = null # Debris House Barrack Archery
var isBuildBlocker = true
var own = GC.OwnEnum.NONE
var units_array = []

func _ready():
	$ProgressBar.connect("end_progress",self,"on_finish_progress")
	GC.set_z_index_to(self)
	yield(get_tree().create_timer(.1),"timeout")
	GC.emit_signal("new_build_created",self)

func on_finish_progress():
	pass #override

func spawn_unit(unitType):
	var UNIT = get_unit_instance(unitType)
	UNIT.position = position
	GC.GAME.add_child(UNIT)
	units_array.append(UNIT)
	UNIT.connect("dead",self,"on_unit_dead")
	if(units_array.size()>=GC.CONFIG.units_per_barrack):
		$ProgressBar.set_active(false)

func on_spawned_unit_dead(unit):
	units_array.remove(unit)
	if(units_array.size()<GC.CONFIG.units_per_barrack):
		$ProgressBar.set_active(true)

func get_unit_instance(unitType):
	if unitType==GC.UnitEnum.MILICIAN: return preload("res://prefabs/units/UnitMilician.tscn").instance()
