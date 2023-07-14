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
	$lb_resources.text = str(GC.data.resources)+" *"
	var buildType = GC.get_current_build_type()
	$BuildMenu.visible = (buildType==GC.BuildEnum.DEBRIS && GC.object_selected.isActive)
