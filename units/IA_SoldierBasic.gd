extends Node2D

export var speed = 30
export var max_distance = 70
var dir
var distance
var target = null
var awaiting = .1
var spd_modif = 1
var velocity = Vector2()

func _ready():
	#$AnimationPlayer.play("Idle")
	$Timer.connect("timeout",self,"check_target")

func _process(delta):
	GC.set_z_index_to(get_parent())
	if awaiting>0:
		awaiting -= delta
		get_node("../AnimatedSprite").play("idle")
		return
	if !is_instance_valid(target): 
		target = GC.PLAYER
		get_node("../AnimatedSprite").play("idle")
		return
	if global_position.distance_to(GC.PLAYER.position)>max_distance: target = GC.PLAYER
	if target == GC.PLAYER && global_position.distance_to(target.position)<35: return
	if target == GC.PLAYER && global_position.distance_to(target.position)>50: spd_modif = global_position.distance_to(target.position)/30
	else: spd_modif = 1
	
	dir = global_position.direction_to(target.position)
	distance = position.distance_to(target.position)
	if distance>10:
		get_node("../AnimatedSprite").flip_h = (dir.x<0)
		get_parent().move_and_slide(dir*speed*spd_modif)
		get_node("../AnimatedSprite").play("walk")
	else: get_node("../AnimatedSprite").play("idle")

func check_target():
	target = GC.get_most_close_health(get_parent(),max_distance)
