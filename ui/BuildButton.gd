extends Button

var cost

func set_data(buildType):
	$Name.text = buildType
	#$Cost.bbcode_text = GC.get_bbcode_cost( BuildsFactory.BuildCosts[buildType] )
	$ResCost.set_cost( BuildsFactory.BuildCosts[buildType] )
