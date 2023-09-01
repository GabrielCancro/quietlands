extends ColorRect

func _ready():
	$Button/Button.connect("button_down",self,"on_click")
	
func on_click():
	get_tree().quit()
