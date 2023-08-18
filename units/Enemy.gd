extends KinematicBody2D

var unitType
var team = 2

func _ready():
	$AnimationPlayer.play("Idle")
	$Weapon.connect("attack",self,"on_attack")

func _process(delta):
	pass

func on_attack(target):
	$IA_EnemyBasic.awaiting = 1
