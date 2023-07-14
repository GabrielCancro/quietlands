extends KinematicBody2D

var unitType # Milician Archer
var speed = 30
var own = "None" # None / Player / Enemy

signal dead(unit)

func _ready():
	$AnimationPlayer.play("Idle")
	GC.set_z_index_to(self)
