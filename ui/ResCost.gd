extends Control

var cost = {"f":3,"w":2,"s":0}
var isBuildeable = false

func _ready():
	set_cost(cost)

func set_cost(_cost):
	cost = _cost
	isBuildeable = true
	var Btns = $HBox.get_children()
	var index = 0
	for b in Btns: b.visible = false
	for c in cost:
		var internal=0
		for i in range(cost[c]):
			Btns[index].visible = true
			if c=="f": Btns[index].get_node("Sprite").frame = 0
			if c=="w": Btns[index].get_node("Sprite").frame = 1
			if c=="s": Btns[index].get_node("Sprite").frame = 2
			if GC.RES[c]>internal: Btns[index].modulate = Color(1,1,1,1)
			else: 
				Btns[index].modulate = Color(1,0,0,1)
				isBuildeable = false
			index += 1
			internal += 1
		Btns[index].visible = true
		Btns[index].get_node("Sprite").frame = 5
		index += 1
	Btns[index-1].visible = false
