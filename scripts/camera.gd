extends Camera2D

func _input(event):
	if event is InputEventScreenDrag:
		if  (position.x <= 884 or event.relative.x > 0) and \
			(position.x >= -109 or event.relative.x < 0) and \
			(position.y <= 115 or event.relative.x > 0) and \
			(position.y >= -840 or event.relative.x < 0):
			position += -event.relative


func _process(delta):
	if (position.x >= 886): position.x -= 20
	if (position.x <= -112): position.x += 20
	if (position.y >= 117): position.y -= 20
	if (position.y <= -842): position.y += 20
	
