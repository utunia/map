extends RayCast2D

var current_highlighted: Array[Node2D] = []

func _process(delta):
	position = get_global_mouse_position()

func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		if is_colliding():
			if current_highlighted.size() > 0:
				var collider = current_highlighted[0]
				var highlight = current_highlighted[1]
				collider.remove_child(highlight)
				current_highlighted.clear()

			var collider_node = get_collider()
			var child_polygon = collider_node.get_child(0) 
			var highlight_color = Color(1, 0.1, 0.5, 1)
			
			var highlight_polygon = create_highlight_polygon(child_polygon.polygon, highlight_color)
			collider_node.add_child(highlight_polygon)
			
			current_highlighted = [collider_node, highlight_polygon]

func create_highlight_polygon(points, color):
	var highlighting: Polygon2D = Polygon2D.new()
	highlighting.polygon = points
	highlighting.color = color
	return highlighting
