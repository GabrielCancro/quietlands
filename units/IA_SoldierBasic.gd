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
	if is_instance_valid(target):
		distance = global_position.distance_to(target.global_position)
		if target==GC.PLAYER: 
			if distance<20: spd_modif = -1
			elif distance<35: spd_modif = 0
			elif distance<50: spd_modif = 1
			elif distance<100: spd_modif = distance/20
			if distance>=100: get_parent().global_position = GC.PLAYER.global_position
		else: #target==enemy
			if distance<10: spd_modif = -1
			elif distance<25: spd_modif = 0
			else: spd_modif = 2
			var distance_from_enemy_to_player = target.global_position.distance_to(GC.PLAYER.global_position)
			if distance_from_enemy_to_player>max_distance: target = GC.PLAYER

	dir = global_position.direction_to(target.global_position)
	if spd_modif!=0:
		get_node("../AnimatedSprite").flip_h = (dir.x<0)
		get_parent().move_and_slide(dir*speed*spd_modif)
		get_node("../AnimatedSprite").play("walk")
	else: get_node("../AnimatedSprite").play("idle")

func check_target():
	target = GC.get_most_close_health(get_parent(),max_distance)
	if !is_instance_valid(target): target = GC.get_most_close_health(GC.PLAYER,max_distance)
