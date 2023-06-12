extends Node2D

var time = 0
var total_time = 1.5

func setText(tx):
	$Label.text = str(tx)

func _process(delta):
	time += delta
	modulate.a = 1 - time / total_time
	position.y -= time
	if time>=total_time: queue_free()
