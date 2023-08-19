extends StaticBody2D

var buildType = "STONE"
var interaction_name = "EXTRACTOR"
var interaction_cost = BuildsFactory.BuildCosts[interaction_name]

func _ready():
	pass

func interact():
	if GC.check_resorces_amount(interaction_cost):
		GC.reduce_resources(interaction_cost)
		var NODE = BuildsFactory.Build(interaction_name,position)
		NODE.extroctor_type = buildType
		NODE.get_node("Sprite").frame = $Sprite.frame
		queue_free()
