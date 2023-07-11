extends Node2D

var buildType = "DEBRIS"
var isActive = false

func _ready():
	$Sprite.modulate = Color(.3,.3,.3,1)
	GC.connect("new_build_created",self,"check_activate")

func check_activate(build):
	if build.position.distance_to(position)<50*$Region.scale.x:
		activate()

func activate():
	if isActive: return
	isActive = true
	$Tween.interpolate_property($Sprite,"modulate",$Sprite.modulate,Color(1,1,1,1),1,Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()
