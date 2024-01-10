extends "res://builds/_BasicBuild.gd"

var lifetime = 0
onready var origin_pos = $Sprite.position
var explored = false

func init():
	buildType = "DARKCRISTAL"
	isEnabled = false
	team = 2
	GC.DARK_CRISTAL_COUNTER += 1
	$healthComponent.connect("dead",self,"on_dead")
	$Weapon.connect("attack",self,"on_attack")

func _process(delta):
	lifetime += delta
	$Sprite.position.y = origin_pos.y + sin(lifetime*3)*3

func on_dead(healtComponent):
	GC.DARK_CRISTAL_COUNTER -= 1
	if GC.DARK_CRISTAL_COUNTER == 0:
		GC.end_game(true)

func on_attack(target):
	if explored: return
	explored = true
	GC.clear_fog_range(global_position/32,3,false)
