extends Control

var speed = 30
var ttl = 0
var last_time = 0
signal close_popup

func _ready():
	visible = false
	GC.POPUP = self
	$Button.connect("button_down",self,"on_click_ok")

func _process(delta):
	$BG/lb_text.visible_characters = floor( max(0,ttl) )
	ttl += speed*delta

func show_popup(code):
	var anim = (OS.get_unix_time() > last_time)
	$BG/lb_text.text = Lang.get_localization(code)
	ttl = 0
	if anim:
		ttl = - speed/2
		modulate.a = 0
		GC.EFFECTOR.appear_ui(self)
	get_tree().paused = true
	visible = true

func on_click_ok():
	get_tree().paused = false
	visible = false
	last_time = OS.get_unix_time()
	emit_signal("close_popup")
