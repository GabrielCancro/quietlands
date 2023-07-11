extends Node2D

var segs = 5
var bon = 3
var isBuildBlocker = true

func _ready():
	$ProgressBar.max_value = segs
	yield(get_tree().create_timer(.1),"timeout")
	GC.emit_signal("new_build_created",self)

func _process(delta):
	$ProgressBar.value += delta
	if($ProgressBar.value>= $ProgressBar.max_value):
		$ProgressBar.value -= $ProgressBar.max_value
		GC.add_resource(bon)
		GC.add_float_text(bon,position+Vector2(0,-50))
