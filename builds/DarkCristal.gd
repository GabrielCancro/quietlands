extends "res://builds/_BasicBuild.gd"

var lifetime = 0
onready var origin_pos = $Sprite.position

func init():
	buildType = "DARKCRISTAL"
	isEnabled = false
	team = 2
	GC.DARK_CRISTAL_COUNTER += 1
	$healthComponent.connect("dead",self,"on_dead")

func _process(delta):
	lifetime += delta
	$Sprite.position.y = origin_pos.y + sin(lifetime*3)*3

func on_dead(healtComponent):
	GC.DARK_CRISTAL_COUNTER -= 1
	if GC.DARK_CRISTAL_COUNTER == 0:
		GC.end_game(true)
