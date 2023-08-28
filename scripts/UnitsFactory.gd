extends Node

var UnitNodes = {
	"MILICIAN": preload("res://units/Soldier.tscn"),
	"ENEMY": preload("res://units/Enemy.tscn"),
}

var UnitsCosts = {
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

func spawn_bullet(pos,target):
	var NODE = preload("res://attacks/bullet.tscn").instance()
	NODE.position = pos
	NODE.target = target
	GC.GAME.get_node("World").add_child(NODE)
	return NODE
