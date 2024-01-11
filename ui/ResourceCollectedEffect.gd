extends Control

var resource = "f"
var val = 1
var time = 1.5

func _ready():
	var toPos = get_viewport().size * Vector2(.8,.2)
	if val<0: toPos = get_viewport().size * Vector2(.8,.5)
	$Tween.interpolate_property(self,"rect_scale",Vector2(1,1),Vector2(2,2),time*.3,Tween.TRANS_QUINT,Tween.EASE_OUT)
	$Tween.interpolate_property(self,"rect_scale",Vector2(2,2),Vector2(1,1),time*.7,Tween.TRANS_QUINT,Tween.EASE_IN,time*.3)
	$Tween.interpolate_property(self,"rect_position",rect_position,toPos,time,Tween.TRANS_CUBIC,Tween.EASE_IN)
	$Tween.interpolate_property(self,"modulate",modulate,Color(1,1,1,0),time*.6,Tween.TRANS_CUBIC,Tween.EASE_IN,time*.4)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	GC.add_one_resource(resource,val)
	queue_free()

func set_resource(res):
	resource = res
	if res=="f": $Sprite.frame = 0
	if res=="w": $Sprite.frame = 1
	if res=="s": $Sprite.frame = 2
