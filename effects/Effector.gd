extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	GC.EFFECTOR = self
	$Particles2D.emitting = false
	$Particles2D.one_shot = true

func dead_fx(pos):
	position = pos
	GC.set_z_index_to(self)
	$Particles2D.one_shot = true
	$Particles2D.emitting = true
