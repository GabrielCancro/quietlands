extends Node

var BuildNodes = {
	"WOOD": preload("res://builds/Wood.tscn"),
	"FOOD": preload("res://builds/Food.tscn"),
	"STONE": preload("res://builds/Stone.tscn"),
	"RUINS": preload("res://builds/Ruins.tscn"),
	
	"HOUSE": preload("res://builds/House.tscn"),
	"BARRACK": preload("res://builds/Barrack.tscn"),
	"EXT_FOOD": preload("res://builds/ExtractorFood.tscn"),
	"EXT_WOOD": preload("res://builds/ExtractorWood.tscn"),
	"EXT_SOOD": preload("res://builds/ExtractorStone.tscn"),
	"CASTLE": preload("res://builds/Castle.tscn"),
}

var BuildCosts = {
	"HOUSE": {"w":2},
	"BARRACK": {"w":2},
	"EXT_FOOD": {"w":2},
	"EXT_WOOD": {"w":2},
	"EXT_STONE": {"w":2},
	"CASTLE": {"s":5},
}

var BuildInPlace = {
	"FOOD": ["EXT_FOOD"],
	"WOOD": ["EXT_WOOD"],
	"STONE": ["EXT_STONE"],
	"RUINS": ["CASTLE", "HOUSE","BARRACK"],
	"BARRACK": ["MILICIAN"],
	"CASTLE": [],
	"PORTAL": [],
	"EXT_FOOD": [],
	"EXT_WOOD": [],
	"EXT_STONE": [],
}

var BUILDINGS = []

func _ready():
	pass # Replace with function body.

func Build(buildType,pos):
	if !buildType in BuildNodes: 
		print("UNEXISTENT BUILD TYPE TO CONSTRUCT")
		return
	var NODE = BuildNodes[buildType].instance()
	NODE.position = pos
	GC.GAME.get_node("World").add_child(NODE)
	BUILDINGS.append(NODE)
	var hc = NODE.get_node_or_null("healthComponent")
	if hc && NODE.has_method("on_dead"): 
		hc.connect("dead",NODE,"on_dead")
		print("CONNECT ON DEAD TO ", NODE.name)
	return NODE

func Build_in_current_place(buildType):
	var Place = GC.PLAYER_BUILDER.current_place
	var pos = Place.position
	var Build = Build(buildType,pos)
	if Build.team == 1: GC.active_near_builds(Build)
	Place.queue_free()
#	Build.inPlace = Place
#	if buildType == "EXTRACTOR": 
#		Build.extractor_type = Place.buildType
#		Build.position -= Vector2(10,7)
#		Place.isBuilded = true
#		Build.get_node("healthComponent").connect("dead",self,"on_dead_build_free_resource")
#	if Place.buildType == "RUINS": 
#		Place.isBuilded = true
#		Place.visible = false
#		Build.get_node("healthComponent").connect("dead",self,"on_dead_build_free_resource")
#	GC.set_z_index_to(Build)
	return Build

func on_dead_build_free_resource(healthComponent):
	BUILDINGS.erase(healthComponent.get_parent())
	var Place = healthComponent.get_parent().inPlace
	Place.isBuilded = false
	Place.visible = true
