extends KinematicBody2D

var destine = Vector2()
var spawner
var unitType # MILICIAN ARCHER
var speed = 30
var wait_time = 0

func _ready():
	$AnimationPlayer.play("Idle")
	destine = position

func _process(delta):
	if !spawner: return
	if position.distance_to(destine)>10:
		var dir = (destine - position).normalized()
		move_and_slide(dir*speed)
		GC.set_z_index_to(self)
	else:
		if wait_time>0:
			wait_time-=delta
		else: 
			wait_time = 3
			destine = spawner.position + Vector2(rand_range(-100,100),rand_range(-100,100))

func set_unit(_spawner,_unitType="NONE"):
	spawner = _spawner
	position = spawner.position
	destine = position
	unitType = _unitType
