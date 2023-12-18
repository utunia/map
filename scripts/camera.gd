extends Camera2D


var MAP_MAX_X = 1407
var MAP_MIN_X = -630
var CAMERA_RANGE_X = 2111


func _process(delta):

	
	if self.position.x > MAP_MAX_X - CAMERA_RANGE_X:
		self.position.x = MAP_MAX_X - CAMERA_RANGE_X
	if self.position.x < MAP_MIN_X - CAMERA_RANGE_X:
		self.position.x = MAP_MIN_X - CAMERA_RANGE_X
