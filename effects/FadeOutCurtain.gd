extends Control

var ttl = 0
var delay = 1

func _ready():
	visible = true

func _process(delta):
	if delay>0: 
		delay -= delta
	else:
		ttl += delta
		modulate.a -= (ttl*ttl)/10
		if modulate.a<0.001: queue_free()
