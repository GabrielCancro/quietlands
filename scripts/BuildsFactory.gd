extends Node

var BuildNodes = {
	"HOUSE": preload("res://builds/House.tscn"),
	"BARRACK": preload("res://builds/Barrack.tscn"),
	"EXTRACTOR": preload("res://builds/Extractor.tscn"),
	"STONE": preload("res://builds/Stone.tscn"),
}

var BuildCosts = {
	"HOUSE": {"w":2},
	"BARRACK": {"w":2},
	"EXTRACTOR": {"w":2},
}

var BuildInPlace = {
	"FOOD": ["EXTRACTOR"],
	"WOOD": ["EXTRACTOR"],
	"STONE": ["EXTRACTOR"],
	"RUINS": ["HOUSE","BARRACK"],
	"PORTAL": [],
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
	var Place = GC.PLAYER.get_node("Builder").current_place
	var pos = Place.position
	Place.queue_free()
	return Build(buildType,pos)
