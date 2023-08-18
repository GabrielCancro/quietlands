extends Node2D

export var cooldown = 1
var team = -1
var _counter_cooldown = 0

signal attack(target)

func _ready():
	if("team" in get_parent()): team = get_parent().team

func _process(delta):
	if(_counter_cooldown<cooldown): _counter_cooldown += delta
	else: try_shot()

func try_shot():
	var minor_distance = 999999
	var candidate = null
	for body in $Area2D.get_overlapping_bodies():
		if !body.get_node_or_null("healthComponent"): continue
		if("team" in body && team>0 && body.team==team): continue
		var distance = global_position.distance_to(body.global_position)
		if distance>minor_distance: continue
		minor_distance = distance
		candidate = body
	if candidate:
		UnitsFactory.spawn_bullet(global_position,candidate)
		_counter_cooldown = 0;
		emit_signal("attack",candidate)
