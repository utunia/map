extends RayCast2D

var current_highlighted: Array[Node2D] = []
var used_colors: Array[Color] = []

func _ready():
	color_areas([1,2,5,3])
	color_areas([11,9,7,6])

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
			var child_polygon: CollisionPolygon2D = collider_node.get_child(0) 
			var highlight_color = Color(34, 23, 45, 0.2)
			var highlight_polygon: Polygon2D = create_highlight_polygon(child_polygon.polygon, highlight_color, child_polygon.global_position, child_polygon.scale)
			collider_node.add_child(highlight_polygon)
			current_highlighted = [collider_node, highlight_polygon]
		
func create_highlight_polygon(points, color, pos=null, scaled=null):
	var highlighting: Polygon2D = Polygon2D.new()
	highlighting.polygon = points
	highlighting.color = color
	if pos:
		highlighting.set_position(pos)
	if scaled:
		highlighting.scale = scaled
	return highlighting


func color_areas(areas: Array[int]):
	var color: Color = Color(randf(), randf(), randf(), 0.5)
	while color in used_colors:
		color = Color(randf(), randf(), randf(), 0.5)
	used_colors.append(color)
	for child in get_parent().get_children():
		if child is Area2D:
			if child.name.to_int() in areas:
				var child_polygon: CollisionPolygon2D = child.get_child(0) 
				child.add_child(create_highlight_polygon(child_polygon.polygon, color, child_polygon.global_position, child_polygon.scale))
