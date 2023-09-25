extends Node2D

export var cooldown = 1.0
export var ran = 60
var team = -1
var _counter_cooldown = 0

signal attack(target)

func _ready():
	if("team" in get_parent()): team = get_parent().team
	$Sprite.visible = false

func _process(delta):
	if(_counter_cooldown<cooldown): _counter_cooldown += delta
	else: try_shot()

func try_shot():
	var candidate = GC.get_most_close_health(get_parent(),ran)
	if candidate:
		UnitsFactory.spawn_bullet(global_position+Vector2(0,-5),candidate)
		_counter_cooldown = 0;
		emit_signal("attack",candidate)
