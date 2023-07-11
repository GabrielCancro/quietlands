extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$btn1.connect("button_down",self,"on_button_1")

func on_button_1():
	var BUILD = preload("res://prefabs/Build.tscn").instance()
	BUILD.position = GC.object_selected.position
	GC.GAME.add_child(BUILD)
	var old_object = GC.object_selected
	GC.select_object(BUILD)
	old_object.queue_free()
