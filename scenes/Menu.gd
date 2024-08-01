extends Control

var light_vars = {"scale":Vector2(7,6),"energy":1}

func _ready():
	randomize()
	light_animation()

func light_animation():
	var scale = Vector2(rand_range(7,8), rand_range(6,7))
	var energy = rand_range(0.8,1.1)
	$LightTween.remove_all()
	$LightTween.interpolate_property($Light2D,"scale",$Light2D.scale,scale,.1,Tween.TRANS_QUAD,Tween.EASE_OUT_IN)
	$LightTween.interpolate_property($Light2D,"energy",$Light2D.energy,energy,.1,Tween.TRANS_QUAD,Tween.EASE_OUT_IN)
	$LightTween.start()
	yield(get_tree().create_timer(.15),"timeout")
	light_animation()
