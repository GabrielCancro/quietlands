extends Control


func _ready():
	GC.RES_POPUP = self
	$Button.connect("button_down",self,"onClick")
	modulate.a = 0

func set_popup(node):
	if node && "interaction_name" in node && node.interaction_name!=null:
		$Name.text = node.interaction_name
		$Cost.bbcode_text = GC.get_bbcode_cost(node.interaction_cost)
		$ResCost.set_cost(node.interaction_cost)
		$Tween.interpolate_property(self,"modulate",modulate,Color(1,1,1,1),.2)
	else: 
		$Tween.interpolate_property(self,"modulate",modulate,Color(0,0,0,0),.2)
	$Tween.start()

func onClick():
	if(GC.PLAYER_BUILDER.current_place && GC.PLAYER_BUILDER.current_place.has_method("interact")): 
		GC.PLAYER_BUILDER.current_place.interact()
