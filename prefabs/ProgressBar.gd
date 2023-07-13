extends Control

var isActived = true
var isLoop = true
var elapsed_time = 0
var total_time = 1

signal end_progress

func _ready():
	pass

func _process(delta):
	elapsed_time += delta
	$On.rect_size.x = $Off.rect_size.x / total_time * elapsed_time
	if elapsed_time>=total_time:
		emit_signal("end_progress")
		if isLoop: 
			elapsed_time -= total_time
		else: 
			set_active(false)
			elapsed_time = total_time 

func set_active(value):
	isActived = value
	visible = isActived
	if !isActived: elapsed_time = 0
	set_process(isActived)

func set_time(value):
	total_time = value
