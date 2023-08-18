extends Node2D

export var speed = 30
var dir
var distance
var target = null
var awaiting = 2

func _ready():
	#$AnimationPlayer.play("Idle")
	$Timer.connect("timeout",self,"check_target")

func _process(delta):
	GC.set_z_index_to(get_parent())
	if awaiting>0:
		awaiting -= delta
		return
	if !target: return
	dir = global_position.direction_to(target.position)
	distance = position.distance_to(target.position)
	if distance>10:
		get_node("../Sprite").flip_h = (dir.x<0)
		get_parent().move_and_slide(dir*speed)

func check_target():
	target = GC.get_most_close_unit(get_parent())
