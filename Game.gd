extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	GC.GAME = self
	$Pointer.connect("change_over_object",$UI,"on_pointer_change")
	$Pointer.connect("select_object",$UI,"on_select_object")
	$Pointer.connect("select_object",$Selector,"on_select_object")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
