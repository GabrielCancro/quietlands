extends Node

var BuildNodes = {
	"HOUSE": preload("res://prefabs/builds/BuildBarrack.tscn")
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func Build(buildType,pos):
	if !buildType in BuildNodes: return
	var NODE = BuildNodes[buildType].instance()
	NODE.position = pos
	GC.GAME.get_node("World").add_child(NODE)
	return NODE

func Build_in_current_place(buildType):
	var Place = GC.PLAYER.get_node("Builder").current_place
	var pos = Place.position
	Place.queue_free()
	return Build(buildType,pos)
