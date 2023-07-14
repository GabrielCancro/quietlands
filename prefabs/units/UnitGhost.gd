extends "res://prefabs/units/UnitBase.gd"

var destine = Vector2()
var wait_time = 0
var original_pos

func _ready():
	destine = position
	original_pos = position

func _process(delta):
	if position.distance_to(destine)>10:
		var dir = (destine - position).normalized()
		$Sprite.flip_h = (dir.x<0)
		move_and_slide(dir*speed)
		GC.set_z_index_to(get_parent())
	else:
		if wait_time>0:
			wait_time-=delta
		else: 
			wait_time = 3
			destine = original_pos + Vector2(rand_range(-100,100),rand_range(-100,100))
