extends Control

var day = 0
var time = 60
var _remain_time = 0
var isNight = true
onready var CanvasModulate = get_node("/root/Game/CanvasModulate")
onready var DarknessNode = get_node("/root/Game/Darkness")
onready var FogTileMap = get_node("/root/Game/World/FogTileMap")

signal change_time(day,isNight)

func _ready():
	GC.DAYNIGHT = self
	start_day()
	$Button.connect("button_down",self,"onClick")

func _process(delta):
	if(_remain_time>0):
		_remain_time -= delta
		if(_remain_time<=0): 
			start_night()
	$Day/TextureProgress.value = (_remain_time/time)*100
	if isNight: 
		if GC.ENEMIES_FROM_PORTAL>0: $lb_enemies.text = "Shadows "+str(GC.ENEMIES_FROM_PORTAL)
		else:
			$lb_enemies.text = ""
			if GC.PORTALS_THAT_ARE_SPAWNING.size()<=0:
				set_process(false)
				yield(get_tree().create_timer(5),"timeout")
				GC.DAYNIGHT.start_day()
				set_process(true)

func start_day():
	if !isNight: return
	$lb_enemies.visible = false
	day += 1
	isNight = false
	_remain_time = time
	$Day/Label.text = "DIA "+str(day)
#	$Tween.interpolate_property(CanvasModulate,"color",CanvasModulate.color,Color(.1,.1,.1,1),1.0)
	$Tween.interpolate_property(DarknessNode,"color",DarknessNode.color,Color(0,0,0,0),1.0)
	$Tween.interpolate_property(FogTileMap,"modulate",FogTileMap.modulate,Color(.5,.5,.5,1),1.0)
	DarknessNode
	$Tween.start()
	emit_signal("change_time",day,isNight)
	GC.collect_resources()

func start_night():
	if isNight: return
	$lb_enemies.visible = true
	_remain_time = 0
	isNight = true
	$Day/Label.text = "NOCHE "+str(day)
#	$Tween.interpolate_property(CanvasModulate,"color",CanvasModulate.color,Color(0,0,0,1),1.0)
	$Tween.interpolate_property(DarknessNode,"color",DarknessNode.color,Color(0,0,.8,.2),1.0)
	$Tween.interpolate_property(FogTileMap,"modulate",FogTileMap.modulate,Color(.2,.2,.7,1),1.0)
	$Tween.start()
	emit_signal("change_time",day,isNight)

func onClick():
	if(!isNight): start_night()
#	else: start_day()
