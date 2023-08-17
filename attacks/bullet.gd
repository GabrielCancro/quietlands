extends Node2D

var target
var speed = 80
var damage = 1

func _ready():
	pass # Replace with function body.

func _process(delta):
	if !target: queue_free()
	else:
		speed += 150*delta
		position += position.direction_to(target.position)*speed*delta
		look_at(target.position)
		GC.set_z_index_to(self)
		if position.distance_to(target.position)<5:
			var healthComponent = target.get_node_or_null("healthComponent")
			if healthComponent: healthComponent.get_damage(damage)
			queue_free()
