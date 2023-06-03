extends Node2D

var over_objects = []
var object_selected = null

var down_mouse_pos
var drag_vector
var draging = false

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
	if !draging: position = get_global_mouse_position()

func on_enter_area(node):
	over_objects.append(node.get_parent())
	if over_objects.size()>0: emit_signal("change_over_object", over_objects[0])
	else: emit_signal("change_over_object", null)

func on_exit_area(node):
	over_objects.erase(node.get_parent())
	if over_objects.size()>0: emit_signal("change_over_object", over_objects[0])
	else: emit_signal("change_over_object", null)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			print("CLICK DOWN")
			down_mouse_pos = position
			drag_vector = Vector2(0,0)
		elif event.button_index == BUTTON_LEFT and !event.pressed:
			print("CLICK UP")
			if down_mouse_pos == position:
				print("ON CLICK")
				object_selected = null
				if over_objects.size()>0: object_selected = over_objects[0]
				emit_signal("select_object", object_selected)
			down_mouse_pos = null
	if down_mouse_pos && event is InputEventMouseMotion:
		if position.distance_to(down_mouse_pos)>0: 
			camera.position -= event.relative
