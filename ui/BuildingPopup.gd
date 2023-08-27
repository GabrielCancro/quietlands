extends Control

var pressed_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_data(" - ")
	yield(get_tree().create_timer(.1),"timeout")
	GC.PLAYER_BUILDER.connect("on_change_current_place",self,"on_change_current_place")

func set_data(name):
	$Name.text = name

func on_change_current_place(node):
	if node: 
		var array = BuildsFactory.BuildInPlace[node.buildType]
		set_data(node.buildType+": "+str(array) )
	else: set_data(" - ")

func _process(delta):
	if Input.is_action_pressed("ui_accept"): pressed_time += delta/2
	else: pressed_time -= delta*2
	pressed_time = min(.3, max (0,pressed_time))
	rect_scale = Vector2(1,1)+Vector2(pressed_time,pressed_time)
