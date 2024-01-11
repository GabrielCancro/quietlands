extends Control

func _ready():
	BuildsFactory.connect("build_one",self,"on_build")
	UnitsFactory.connect("train_one",self,"on_train")

func update_ui():
	$HBox/Res1/Label.text = str(GC.RES["f"])
	$HBox/Res2/Label.text = str(GC.RES["w"])
	$HBox/Res3/Label.text = str(GC.RES["s"])
	$HBox/Res4/Label.text = str(GC.TOTAL_SOLDIERS)
	$HBox/Res4/Label3.text = str(GC.RES["p"])
	calculate_extras()

func calculate_extras():
	var food = 0
	var wood = 0
	var stone = 0
	for b in BuildsFactory.BUILDINGS:
		if !is_instance_valid(b): continue
		if b.buildType=="EXT_FOOD": food += 2
		if b.buildType=="EXT_WOOD": wood += 2
		if b.buildType=="EXT_STONE": stone += 2
		if b.buildType=="CASTLE":
			food += 1
			wood += 1
			stone += 1
	for un in UnitsFactory.UNITS:
		if !is_instance_valid(un): continue
		if un.team==1: food -= 1
	if food>=0: $HBox/Res1/Label2.text = "+"+str(food)
	else: $HBox/Res1/Label2.text = str(food)
	if wood>=0: $HBox/Res2/Label2.text = "+"+str(wood)
	else: $HBox/Res2/Label2.text = str(wood)
	if stone>=0: $HBox/Res3/Label2.text = "+"+str(stone)
	else: $HBox/Res3/Label2.text = str(stone)

func on_build(buildNode):
	calculate_extras()

func on_train(unitNode):
	calculate_extras()
