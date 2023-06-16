extends Node2D

var over_objects = []
var object_selected = null

var down_mouse_pos
var down_camera_pos
var excludes = ["Builder","Pointer","CenterPointer"]

onready var camera = get_node("../Camera2D")

signal change_over_object(node)
signal select_object(node)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("area_entered",self,"on_enter_area")
	$Area2D.connect("area_exited",self,"on_exit_area")
	emit_signal("change_over_object", null)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = get_global_mouse_position()

func on_enter_area(node_area):
	var node = node_area.get_parent()
	if excludes.has(node.name): return
	over_objects.append(node)
	if over_objects.size()>0: emit_signal("change_over_object", over_objects[0])
	else: emit_signal("change_over_object", null)

func on_exit_area(node_area):
	var node = node_area.get_parent()
	if excludes.has(node.name): return
	over_objects.erase(node)
	if over_objects.size()>0: emit_signal("change_over_object", over_objects[0])
	else: emit_signal("change_over_object", null)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			down_mouse_pos = position
			down_camera_pos = get_node("../Camera2D").position
		elif event.button_index == BUTTON_LEFT and !event.pressed:
			object_selected = null
			if get_node("../Camera2D").position.distance_to(down_camera_pos)<25:
				if over_objects.size()>0:
					if position.distance_to(down_mouse_pos)<1:
						object_selected = over_objects[0]
			emit_signal("select_object", object_selected)
			down_mouse_pos = null
	if down_mouse_pos && event is InputEventMouseMotion:
			camera.position -= event.relative
