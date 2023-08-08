extends "res://prefabs/units/UnitBase.gd"

func _ready():
	._ready()
	own = "Enemy"

func on_destine():
	.on_destine()
	yield(get_tree().create_timer(3),"timeout")
	destine = original_pos + Vector2(rand_range(-100,100),rand_range(-100,100))
