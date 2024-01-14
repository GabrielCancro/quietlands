extends Control

func _ready():
	BuildsFactory.connect("build_one",self,"on_build")
	UnitsFactory.connect("train_one",self,"on_train")

func update_ui():
	$HBox/Res1/Label.text = str(GC.RES["f"])
	$HBox/Res1/Label2.text = str(GC.RES["xf"])
	if GC.RES["xf"]>=0: $HBox/Res1/Label2.text = "+"+$HBox/Res1/Label2.text
	$HBox/Res2/Label.text = str(GC.RES["w"])
	$HBox/Res2/Label2.text = str(GC.RES["xw"])
	if GC.RES["xw"]>=0: $HBox/Res2/Label2.text = "+"+$HBox/Res2/Label2.text
	$HBox/Res3/Label.text = str(GC.RES["s"])
	$HBox/Res3/Label2.text = str(GC.RES["xs"])
	if GC.RES["xs"]>=0: $HBox/Res3/Label2.text = "+"+$HBox/Res3/Label2.text
	$HBox/Res4/Label.text = str(GC.TOTAL_SOLDIERS)
	$HBox/Res4/Label3.text = str(GC.RES["p"])

func on_build(buildNode):
	update_ui()

func on_train(unitNode):
	update_ui()
