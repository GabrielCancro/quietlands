extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	GC.EFFECTOR = self

func dead_fx(pos):
	var NODE = preload("res://effects/fx_blood.tscn").instance()
	NODE.position = pos
	add_child(NODE)

func shine(pos):
	var NODE = preload("res://effects/fx_shine.tscn").instance()
	NODE.position = pos
	add_child(NODE)
