extends Control

var i_diapo = 0
var t = 0

func _ready():
	for i in range(5): add_diapo_fx( "D"+str(i+1), 4+i*13 )
	$btn_skip.connect("button_down",self,"skip")

func add_diapo_fx(DN,time):
	t = time
	appear(DN          ,t     )
	appear(DN+"/L1"    ,t     )
	appear(DN+"/IMG1"  ,t+2.5,  5 )
	appear(DN+"/L2"    ,t+4 )
	disappear(DN       ,t+10   )
	yield(get_tree().create_timer(70),"timeout")
	skip()

func appear(path, delay, duration = 1):
	var node = get_node_or_null("Diapos/"+path)
	if !node: return
	node.modulate.a = 0
	node.visible = true
	yield(get_tree().create_timer(delay),"timeout")
	$Tween.interpolate_property(node,"modulate:a",null, 1, duration, Tween.TRANS_QUAD,Tween.EASE_OUT  )
	$Tween.start()

func disappear(path, delay, duration = 2):
	var node = get_node_or_null("Diapos/"+path)
	if !node: return
	yield(get_tree().create_timer(delay),"timeout")
	$Tween.remove(node,"modulate:a")
	$Tween.interpolate_property(node,"modulate:a",null, 0, duration, Tween.TRANS_QUAD,Tween.EASE_IN  )
	$Tween.start()

func skip():
	get_tree().change_scene("res://scenes/Menu.tscn")
