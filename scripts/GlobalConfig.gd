extends Node

var GAME

var data = {
	"resources": 10
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_resource(cnt=0):
	data.resources += cnt
	GAME.get_node("UI").update_ui()

func add_float_text(tx,pos):
	var FX = preload("res://fx/FloatText.tscn").instance()
	FX.position = pos
	FX.setText(tx)
	GAME.add_child(FX)
