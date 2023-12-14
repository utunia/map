extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(_delta):
	pass

func _gui_input(event):
	if event is InputEventMouseButton and event.is_pressed and not event.canceled:
		var clicked_point = event.position
		for child in get_children():
			if child is TextureRect:
				var rect = child.get_rect()
				if rect.has_point(event.position):
					print("Clicked TextureRect with ID:", child.name)
					break

