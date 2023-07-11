extends Node2D

func _ready():
	on_select_object(null)

func on_select_object(node):
	visible = false
	if node:
		visible = true
		position = node.position
