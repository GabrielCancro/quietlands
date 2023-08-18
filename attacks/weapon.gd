extends Node2D

export var cooldown = 1
export var ran = 60
var team = -1
var _counter_cooldown = 0

signal attack(target)

func _ready():
	if("team" in get_parent()): team = get_parent().team

func _process(delta):
	if(_counter_cooldown<cooldown): _counter_cooldown += delta
	else: try_shot()

func try_shot():
	var candidate = GC.get_most_close_unit(get_parent(),ran)
	if candidate:
		UnitsFactory.spawn_bullet(global_position,candidate)
		_counter_cooldown = 0;
		emit_signal("attack",candidate)