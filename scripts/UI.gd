extends CanvasLayer

signal on_button(btn)

# Called when the node enters the scene tree for the first time.
func _ready():
	update_ui()

func on_pointer_change(node):
	$lb_pointer.text = "..."
	if node: $lb_pointer.text = node.name

func on_select_object(node):
	if node: print(node.name)
	else: print("none")
	update_ui()

func update_ui():
	$lb_resources.text = "FOOD "+str(GC.RES["f"])+" +"+str(GC.RES_BON["f"])+"    "
	$lb_resources.text += "WOOD "+str(GC.RES["w"])+" +"+str(GC.RES_BON["w"])+"    "
	$lb_resources.text += "STONE "+str(GC.RES["s"])+" +"+str(GC.RES_BON["s"])
	var buildType = GC.get_current_build_type()
#	$BuildMenu.update_menu(buildType)
	
