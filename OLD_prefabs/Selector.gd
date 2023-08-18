extends Node2D

func _ready():
	on_select_object(null)
	scale_fx()

func on_select_object(node):
	visible = false
	if node:
		visible = true
		position = node.position
		GC.set_z_index_to(self,-10)

func scale_fx():
	$Tween.remove_all()
	var rand_scale = Vector2( rand_range(0.35,0.4), rand_range(0.3,0.35))
	var rand_mod = Color( 1, 1, 0, rand_range(0.3,0.7))
	$Tween.interpolate_property($Sprite,"scale",$Sprite.scale,rand_scale,.2)
	$Tween.interpolate_property($Sprite,"modulate",$Sprite.modulate,rand_mod,.1)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	scale_fx()
