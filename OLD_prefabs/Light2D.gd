extends Light2D

onready var base_rad = texture_scale
onready var toScale = texture_scale

func _process(delta):
	texture_scale = lerp(texture_scale,toScale,0.2)
	if(abs(toScale-texture_scale)<0.005): 
		var day_light = 1.35
		if GC.DAYNIGHT.isNight: day_light = 1
		toScale = rand_range(base_rad*day_light,base_rad*day_light*1.03)
