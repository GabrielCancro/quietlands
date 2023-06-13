extends Node2D

var over_objects = []
var object_selected = null

var down_mouse_pos
var drag_vector
var draging = false
var excludes = ["Builder","Pointer"]

onready var camera = get_node("../Camera2D")

signal change_over_object(node)
signal select_object(node)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("area_entered",self,"on_enter_area")
	$Area2D.connect("area_exited",self,"on_exit_area")
	emit_signal("change_over_object", null)

func on_enter_area(node):
	node = node.get_parent()
	if excludes.has(node.name): return
	if node.name == "Builder": return
	over_objects.append(node)
	if over_objects.size()>0: emit_signal("change_over_object", over_objects[0])
	else: emit_signal("change_over_object", null)

func on_exit_area(node):
	node = node.get_parent()
	if excludes.has(node.name): return
	over_objects.erase(node)
	if over_objects.size()>0: emit_signal("change_over_object", over_objects[0])
	else: emit_signal("change_over_object", null)
