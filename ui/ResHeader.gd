extends Control


func _ready():
	pass # Replace with function body.

func update_ui():
	$HBox/Res1/Label.text = str(GC.RES["f"])
	$HBox/Res2/Label.text = str(GC.RES["w"])
	$HBox/Res3/Label.text = str(GC.RES["s"])
