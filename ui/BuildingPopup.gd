extends Control

var pressed_time = 0
var array_actions = []
var index = 0
var interaction_cost = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	set_data()
	yield(get_tree().create_timer(.1),"timeout")
	GC.PLAYER_BUILDER.connect("on_change_current_place",self,"on_change_current_place")

func set_data():
	set_button_data($Button1,-1)
	set_button_data($Button2,-1)
	if array_actions.size()<=0: return
	interaction_cost = get_cost(array_actions[index])
	set_button_data($Button1,index)
	if array_actions.size()==1: return
	var next = index+1
	if next >= array_actions.size(): next = 0
	set_button_data($Button2,next)

func on_change_current_place(node):
	if node && node.buildType in BuildsFactory.BuildInPlace: 
		array_actions = BuildsFactory.BuildInPlace[node.buildType]
	else: array_actions = []
	index = 0
	set_data()

func _process(delta):
	if array_actions.size()==0: return
	if Input.is_action_pressed("ui_accept"): pressed_time += delta/2
	else: pressed_time -= delta*2
	pressed_time = min(.3, max (0,pressed_time))
	$Button1.rect_scale = Vector2(1,1)+Vector2(pressed_time,pressed_time)
	if !$Button1/ResCost.isBuildeable: pressed_time = 0
	if(pressed_time >= .3): 
		pressed_time = 0
		$Button1.rect_scale = Vector2(1,1)
		GC.reduce_resources(interaction_cost)
		if(array_actions[index] in BuildsFactory.BuildNodes): BuildsFactory.Build_in_current_place(array_actions[index])
		elif(array_actions[index] in UnitsFactory.UnitNodes): UnitsFactory.spawn_unit(array_actions[index],GC.PLAYER_BUILDER.current_place.position)
		set_process(false)
		yield(get_tree().create_timer(.5),"timeout")
		set_process(true)

func _input(event):
	if array_actions.size()>0 && event.is_action_pressed("ui_cancel"):
		index += 1
		if index >= array_actions.size(): index = 0
		set_data()

func set_button_data(btn,_index):
	if _index==-1: btn.visible = false
	else:
		btn.visible = true
		btn.get_node("Name").text = array_actions[_index]
		btn.get_node("ResCost").set_cost(get_cost(array_actions[_index]))

func get_cost(type):
	if type in BuildsFactory.BuildCosts: return BuildsFactory.BuildCosts[type]
	elif type in UnitsFactory.UnitsCosts: return UnitsFactory.UnitsCosts[type]
	
