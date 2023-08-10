extends "res://prefabs/builds/BuildBase.gd"

var isActive = false
var isBuilded = false

func _ready():
	buildType = GC.BuildEnum.RESOURCE
	own = GC.OwnEnum.NONE
	vision_range = 0
	$Sprite.modulate = Color(.3,.3,.3,1)
	GC.connect("new_build_created",self,"check_activate")

func check_activate(build):
	if(build.own!=GC.OwnEnum.PLAYER): return
	if build.position.distance_to(position)<50*$Region.scale.x:
		activate()

func activate():
	if isActive: return
	isActive = true
	vision_range = 1
	GC.clear_fog(position,vision_range)
	$Tween.interpolate_property($Sprite,"modulate",$Sprite.modulate,Color(1,1,1,1),1,Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()

func build():
	isBuilded = true
	$Sprite2.visible = true
