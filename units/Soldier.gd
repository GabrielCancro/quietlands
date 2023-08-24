extends KinematicBody2D

var unitType
var team = 1

func _ready():
	$AnimationPlayer.play("Idle")
	$Weapon.connect("attack",self,"on_attack")

func _process(delta):
	pass

func on_attack(target):
	$IA_SoldierBasic.awaiting = 1
