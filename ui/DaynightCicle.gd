extends Control

var day = 0
var time = 60
var _remain_time = 0
var isNight = true
onready var CanvasModulate = get_node("/root/Game/CanvasModulate")

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
	if isNight: $lb_enemies.text = "Shadows "+str(GC.ENEMIES_FROM_PORTAL)
	

func start_day():
	if !isNight: return
	$lb_enemies.visible = false
	day += 1
	isNight = false
	_remain_time = time
	$Day/Label.text = "DIA "+str(day)
	$Tween.interpolate_property(CanvasModulate,"color",CanvasModulate.color,Color(.6,.6,.6,1),1.0)
	$Tween.start()
	emit_signal("change_time",day,isNight)
	GC.collect_resources()

func start_night():
	if isNight: return
	$lb_enemies.visible = true
	_remain_time = 0
	isNight = true
	$Day/Label.text = "NOCHE "+str(day)
	$Tween.interpolate_property(CanvasModulate,"color",CanvasModulate.color,Color(0.1,.1,.1,1),1.0)
	$Tween.start()
	emit_signal("change_time",day,isNight)

func onClick():
	if(!isNight): start_night()
