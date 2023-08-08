extends KinematicBody2D

var unitType # Milician Archer
var speed = 30
var own = "None" # None / Player / Enemy
var destine = Vector2()
var original_pos
var limit_time_to_move = 7
var target = null
var range_of_attack = 20
var damage = 5
var reload_attack = 3
var hp = 30
var impulse = Vector2()

signal dead(unit)
signal on_destine()
signal on_low_update()

func _ready():
	$AnimationPlayer.play("Idle")
	GC.set_z_index_to(self)
	$Timer.connect("timeout",self,"low_update")
	GC.UNITS.append(self)
	destine = position
	original_pos = position
	on_destine()

func _process(delta):
	var dir = Vector2.ZERO
	if reload_attack>0: reload_attack -= delta
	if target: 
		destine = target.position
		if position.distance_to(destine)<range_of_attack:
			dir = (destine - position).normalized()
			destine = position
			if reload_attack<=0:
				target.get_damage(damage,dir*50)
				target = null
	if position.distance_to(destine)>10 && limit_time_to_move>0:
		limit_time_to_move -= delta
		dir = (destine - position).normalized()
		$Sprite.flip_h = (dir.x<0)
	else:
		if(destine!=position):
			destine = position
			limit_time_to_move = 7
			on_destine()
	impulse *= 0.97
	move_and_slide(dir*speed+impulse)
	GC.set_z_index_to(get_parent())

func low_update():
	target = null
	var distance = 200
	for un in GC.UNITS:
		if is_instance_valid(un) && un.own!=own && position.distance_to(un.position)<distance:
			distance = position.distance_to(un.position)
			target = un

func on_destine():
	pass

func get_damage(damage,imp=Vector2()):
	impulse = imp
	hp -= rand_range(damage,damage*2)
	print(name+" HP:"+str(hp))
	if hp<=0: 
		GC.UNITS.erase(self)
		queue_free()
