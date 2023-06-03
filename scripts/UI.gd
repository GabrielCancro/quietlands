extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("../World/Pointer").connect("change_over_object",self,"on_pointer_change")
	get_node("../World/Pointer").connect("select_object",self,"on_select_object")

func on_pointer_change(node):
	$lb_pointer.text = "..."
	if node: $lb_pointer.text = node.name

func on_select_object(node):
	if node: print(node.name)
	else: print("none")
