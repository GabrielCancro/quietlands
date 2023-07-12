extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for t in $Trees.get_children():
		GC.set_z_index_to(t)
	for s in $Structures.get_children():
		GC.set_z_index_to(s)
