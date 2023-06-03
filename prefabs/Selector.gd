extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	on_select_object(null)

func on_select_object(node):
	visible = false
	if node:
		visible = true
		position = node.position
