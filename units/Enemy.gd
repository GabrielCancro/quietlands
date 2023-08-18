extends KinematicBody2D

var unitType
var team = 2

func _ready():
	$AnimationPlayer.play("Idle")

func _process(delta):
	pass
