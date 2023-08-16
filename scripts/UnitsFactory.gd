extends Node

var UnitNodes = {
	"MILICIAN": preload("res://prefabs/units/UnitMilician.tscn"),
}

var UnitCosts = {
	"MILICIAN": {"f":2},
}

var UNITS = []

func _ready():
	pass # Replace with function body.

func spawn_unit(unitType,pos):
	if !unitType in UnitNodes: return
	var NODE = UnitNodes[unitType].instance()
	NODE.position = pos
	GC.GAME.get_node("World").add_child(NODE)
	UNITS.append(NODE)
	return NODE
