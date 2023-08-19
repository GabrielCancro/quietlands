extends StaticBody2D

var buildType = "BARRACK"
var team = 1
var interaction_name = "MILICIAN"
var interaction_cost = UnitsFactory.UnitCosts[interaction_name]

func _ready():
	pass # Replace with function body.

func interact():
	if GC.check_resorces_amount(interaction_cost):
		GC.reduce_resources(interaction_cost)
		UnitsFactory.spawn_unit(interaction_name,GC.PLAYER.position)
