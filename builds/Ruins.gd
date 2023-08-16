extends StaticBody2D

var buildType = "RUINS"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact():
	GC.GAME.get_node("UI/BuildMenu").show_menu()
