extends Node

var BuildNodes = {
	"HOUSE": preload("res://builds/House.tscn"),
	"BARRACK": preload("res://builds/Barrack.tscn"),
	"EXTRACTOR": preload("res://builds/Extractor.tscn"),
	"CASTLE": preload("res://builds/Castle.tscn"),
}

var BuildCosts = {
	"HOUSE": {"w":2},
	"BARRACK": {"w":2},
	"EXTRACTOR": {"w":2},
	"CASTLE": {"s":5},
}

var BuildInPlace = {
	"FOOD": ["EXTRACTOR"],
	"WOOD": ["EXTRACTOR"],
	"STONE": ["EXTRACTOR"],
	"RUINS": ["CASTLE", "HOUSE","BARRACK"],
	"BARRACK": ["MILICIAN"],
	"CASTLE": [],
	"PORTAL": [],
	"EXTRACTOR": [],
}

var BUILDINGS = []

func _ready():
	pass # Replace with function body.

func Build(buildType,pos):
	if !buildType in BuildNodes: return
	var NODE = BuildNodes[buildType].instance()
	NODE.position = pos
	GC.GAME.get_node("World").add_child(NODE)
	BUILDINGS.append(NODE)
	return NODE

func Build_in_current_place(buildType):
	var Place = GC.PLAYER_BUILDER.current_place
	var pos = Place.position
	var Build = Build(buildType,pos)
	Build.inPlace = Place
	if buildType == "EXTRACTOR": 
		Build.extractor_type = Place.buildType
		Build.position -= Vector2(10,7)
	if Place.has_method("set_enabled"): 
		Place.set_enabled(false)
		Build.get_node("healthComponent").connect("dead",self,"on_dead_build")
	GC.set_z_index_to(Build)
	return Build

func on_dead_build(healthComponent):
	var Place = healthComponent.get_parent().inPlace
	if Place.has_method("set_enabled"): Place.set_enabled(true)
