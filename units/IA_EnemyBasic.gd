extends Node2D

export var speed = 30
var dir
var distance
var target = null
var awaiting = .1
onready var _agent = get_node_or_null("../NavigationAgent2D") as NavigationAgent2D

func _ready():
	#$AnimationPlayer.play("Idle")
	$Timer.connect("timeout",self,"check_target")
	update_location_loop()

func _process(delta):
	GC.set_z_index_to(get_parent())
	if awaiting>0:
		awaiting -= delta
		return
	if !is_instance_valid(target): return
#	dir = global_position.direction_to(target.position)
	distance = position.distance_to(target.position)
	
	dir = global_position.direction_to(_agent.get_next_location()).normalized()
	if distance>10:
#		var myPath = (GC.NAV2D as Navigation2D).get_simple_path(global_position, target.global_position)
#		(GC.LINE2D as Line2D).points = _agent.get_nav_path()
#		dir = myPath[0].direction_to(myPath[1])
		get_node("../Sprite").flip_h = (dir.x<0)
		get_parent().move_and_slide(dir*speed)

func check_target():
	target = GC.get_most_close_health(get_parent())

func update_location_loop():
	if is_instance_valid(target):
		_agent.set_target_location(target.position)
	yield(get_tree().create_timer(.5),"timeout")
	if(is_instance_valid(self)): update_location_loop()
