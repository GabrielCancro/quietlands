extends Node2D

var over_objects = []
var down_mouse_pos
var down_camera_pos
var excludes = ["Pointer"]

signal change_over_object(node)

func _ready():
	GC.POINTER = self
	$Area2D.connect("body_entered",self,"on_enter_area")
	$Area2D.connect("body_exited",self,"on_exit_area")
	emit_signal("change_over_object", null)

func _process(delta):
	position = get_global_mouse_position()

func on_enter_area(node_area):
	var node = node_area
	if excludes.has(node.name): return
	over_objects.append(node)
	if over_objects.size()>0: emit_signal("change_over_object", over_objects[0])
	else: emit_signal("change_over_object", null)

func on_exit_area(node_area):
	var node = node_area
	if excludes.has(node.name): return
	over_objects.erase(node)
	if over_objects.size()>0: emit_signal("change_over_object", over_objects[0])
	else: emit_signal("change_over_object", null)

func _input(event):
	var camera = GC.PLAYER.get_node("Camera2D")
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			down_mouse_pos = position
			down_camera_pos = camera.position
		elif event.button_index == BUTTON_LEFT and !event.pressed:
			var object_selected = null
			if !down_camera_pos: return
			if camera.position.distance_to(down_camera_pos)<25:
				if over_objects.size()>0:
					object_selected = over_objects[0]
			GC.select_object(object_selected)
			down_mouse_pos = null
	if down_mouse_pos && event is InputEventMouseMotion:
			camera.position -= event.relative
