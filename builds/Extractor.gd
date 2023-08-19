extends StaticBody2D

var buildType = "EXTRACTOR"
var team = 1
var extroctor_type #FOOD-WOOD-STONE
var extractor_frame = -1

func _ready():
	$healthComponent.connect("dead",self,"on_dead")

func interact():
	pass

func on_dead(node):
	var NODE = BuildsFactory.Build(extroctor_type,position)
