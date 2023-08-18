extends Node2D

export var speed = 30
var dir
var distance
var target = null
var team = -1
var awaiting = 3

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
		$Sprite.flip_h = (dir.x<0)
		get_parent().move_and_slide(dir*speed)

func check_target():
	var candidate = null
	var distance = 99999
	for un in GC.UNITS:
		if !is_instance_valid(un): continue
		if team != -1 && "team" in un && un.team==team: continue
		if global_position.distance_to(un.position)>distance: continue
		distance = global_position.distance_to(un.position)
		candidate = un
	if candidate: 
		target = candidate
