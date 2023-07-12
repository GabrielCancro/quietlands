extends StaticBody2D

var buildType = null #HOUSE BARRACK ARCHERY
var isBuildBlocker = true

func _ready():
	if !buildType: set_build_type("HOUSE")
	yield(get_tree().create_timer(.1),"timeout")
	GC.emit_signal("new_build_created",self)

func _process(delta):
	$ProgressBar.value += delta
	if($ProgressBar.value>= $ProgressBar.max_value):
		$ProgressBar.value -= $ProgressBar.max_value
		on_finish_progress()

func set_build_type(_buildType="NONE"):
	buildType = _buildType
	$ProgressBar.value = 0
	GC.set_z_index_to(self)
	if buildType=="HOUSE":
		$ProgressBar.max_value = 5
		$Sprite.frame = 30
	elif buildType=="BARRACK":
		$ProgressBar.max_value = 5
		$Sprite.frame = 29
	elif buildType=="ARCHERY":
		$ProgressBar.max_value = 5
		$Sprite.frame = 28

func on_finish_progress():
	if buildType=="HOUSE":
		GC.add_resource(3)
		GC.add_float_text(3,position+Vector2(0,-50))
	elif buildType=="BARRACK":
		var UNIT = preload("res://prefabs/Unit.tscn").instance()
		UNIT.set_unit(self,"MILICIAN")
		GC.GAME.add_child(UNIT)
	elif buildType=="ARCHERY":
		GC.add_float_text("A",position+Vector2(0,-50))
