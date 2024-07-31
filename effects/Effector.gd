extends Node2D
var tween = Tween.new()

func _ready():
	GC.EFFECTOR = self
	tween.pause_mode = PAUSE_MODE_PROCESS
	add_child(tween)

func dead_fx(pos):
	var NODE = preload("res://effects/fx_blood.tscn").instance()
	NODE.position = pos
	add_child(NODE)

func shine(pos):
	var NODE = preload("res://effects/fx_shine.tscn").instance()
	NODE.position = pos
	add_child(NODE)

func appear_ui(node):
	tween.interpolate_property(node,"modulate:a",0,1,.3,Tween.TRANS_QUAD,Tween.EASE_IN)
	tween.start()
