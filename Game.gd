extends Node2D

func _ready():
	GC.GAME = self
#	$Camera2D/CenterPointer.connect("change_over_object",$UI,"on_pointer_change")
	$Pointer.connect("change_over_object",$UI,"on_pointer_change")
	GC.connect("on_select_object",$UI,"on_select_object")
	GC.connect("on_select_object",$Selector,"on_select_object")
