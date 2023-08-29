extends StaticBody2D

var team = 2

func _ready():
	GC.ZIGURATS_COUNTER += 1
	$healthComponent.connect("dead",self,"on_dead")
	pass # Replace with function body.

func on_dead(healtComponent):
	GC.ZIGURATS_COUNTER -= 1
	if GC.ZIGURATS_COUNTER == 0:
		print("WIN!!!")
