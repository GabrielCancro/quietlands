extends Node2D

func _ready():
	GC.CONNECTOR = self

func create_connection(node1,node2):
	var Line = Line2D.new()
	Line.width = 2
	Line.default_color = Color(.8,.4,.4,.3)
	Line.add_point(node1.global_position)
	Line.add_point(node2.global_position)
	add_child(Line)

func connect_near_builds(build):
	for b in GC.RESOURCE_NODES:
		var dist = b.global_position.distance_to(build.global_position)
		print("CONNECTOR ",dist)
		if dist<150:
			create_connection(build,b)
