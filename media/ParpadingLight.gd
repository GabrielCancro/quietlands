extends Light2D

onready var b_scale = scale 
onready var b_energy = energy 

func _ready():
	randomize()
	light_animation()

func _process(delta):
	color.a = get_parent().modulate.a

func light_animation():
	var to_scale = b_scale*Vector2(rand_range(.95,1.05), rand_range(.95,1.05) )
	var to_energy = b_energy*rand_range(0.95,1.05)
	$Tween.remove_all()
	$Tween.interpolate_property(self,"scale",scale,to_scale,.08,Tween.TRANS_QUAD,Tween.EASE_OUT_IN)
	$Tween.interpolate_property(self,"energy",energy,to_energy,.08,Tween.TRANS_QUAD,Tween.EASE_OUT_IN)
	$Tween.start()
	yield(get_tree().create_timer(.09),"timeout")
	light_animation()
