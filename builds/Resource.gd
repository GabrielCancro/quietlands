extends StaticBody2D

export var buildType = "NONE"
var interaction_name = "EXTRACTOR"
var interaction_cost = BuildsFactory.BuildCosts[interaction_name]

func _ready():
	GC.set_z_index_to(self)
	var Anim = get_node_or_null("AnimationPlayer")
	if Anim: 
		Anim.play("wind")
		Anim.seek(rand_range(0,5))

func interact():
	if!interaction_name: return
	if GC.check_resorces_amount(interaction_cost):
		GC.reduce_resources(interaction_cost)
		var NODE = BuildsFactory.Build(interaction_name,position-Vector2(10,7))
		NODE.extractor_type = buildType
		NODE.get_node("healthComponent").connect("dead",self,"on_dead_extractor")
		interaction_name = null

func on_dead_extractor(node):
	interaction_name = "EXTRACTOR"
