extends RayCast2D

var current_highlighted: Array[Node2D] = []
var used_colors: Array[Color] = []

func _ready():
	color_areas([1,2,5,3])
	color_areas([11,9,7,6])
	color_areas([4,8,10,12])
	color_areas([13,14,15])
	

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
	var color: Color = generate_color()
	while color in used_colors:
		color = generate_color()
	used_colors.append(color)
	for child in get_parent().get_children():
		if child is Area2D:
			if child.name.to_int() in areas:
				var child_polygon: CollisionPolygon2D = child.get_child(0) 
				child.add_child(create_highlight_polygon(child_polygon.polygon, color, child_polygon.global_position, child_polygon.scale))


func generate_color():
	var separation = 0.2 
	var red = randf_range(0., 1. - separation)
	var green = randf_range(0., 1. - separation)
	var blue = randf_range(0., 1. - separation)
	red = (red + 1. - separation) / 2 
	green = (green + 1. - separation) / 2 
	blue = (blue + 1. - separation) / 2
	return Color(red, green, blue, 0.6)

	
