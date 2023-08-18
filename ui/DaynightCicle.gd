extends Control

var day = 1
var time = 7
var _remain_time = 0

func _ready():
	start_day()

func _process(delta):
	if(_remain_time>0):
		_remain_time -= delta
		if(_remain_time<=0): 
			start_night()
	$Day/TextureProgress.value = (_remain_time/time)*100
	

func start_day():
	_remain_time = time
	$Day/Label.text = "DIA "+str(day)
	print("ES El DIA!")

func start_night():
	_remain_time = 0
	print("ES LA NOCHE!")
