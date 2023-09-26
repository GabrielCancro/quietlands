extends Node2D

func _ready():
	$AnimatedSprite.frame = 0
	$AnimatedSprite.playing = true
	$AnimatedSprite.connect("animation_finished",self,"end")
	GC.set_z_index_to(self,20)

func end():
	queue_free()
