extends CanvasLayer

signal on_button(btn)

# Called when the node enters the scene tree for the first time.
func _ready():
	$btn_build.connect("button_down",get_node("../Camera2D/Builder"),"on_build_button_click")
	update_ui()

func on_pointer_change(node):
	$lb_pointer.text = "..."
	if node: $lb_pointer.text = node.name

func on_select_object(node):
	if node: print(node.name)
	else: print("none")

func update_ui():
	$lb_resources.text = str(GC.data.resources)+" *"
