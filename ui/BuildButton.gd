extends Button

var cost

func set_data(buildType):
	$Name.text = buildType
	$Cost.bbcode_text = "[center]"
	cost = BuildsFactory.BuildCosts[buildType]
	add_resource_number("f")
	$Cost.bbcode_text += " / "
	add_resource_number("w")
	$Cost.bbcode_text += " / "
	add_resource_number("s")

func add_resource_number(key):
	if !key in cost: $Cost.bbcode_text += "-"
	elif GC.RES[key]>=cost[key]: $Cost.bbcode_text += str(cost[key])
	else: $Cost.bbcode_text += "[color=red]"+str(cost[key])+"[/color]"
