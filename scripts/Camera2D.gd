extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_node("../World/Build").position *10
	print(position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
