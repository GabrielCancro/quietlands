extends Node2D

func _ready():
	$Enemies/Portal.spawn_list = [
		{"day":1, "type":"I", "step":2, "enemy":"GHOST"},
		{"day":2, "type":"I", "step":3, "enemy":"GHOST"},
		{"day":3, "type":"I", "step":4, "enemy":"GHOST"},
	]

