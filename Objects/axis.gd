extends Node
class_name Axis

var direction: float
var old_direction: float
var frames_until_change: int
var current_frames
func _init(frames_until_change: int):
	self.frames_until_change = frames_until_change
	direction = 0
	current_frames = 0
	
func get_input(new_direction: float):
	if new_direction != direction:
		old_direction = direction
		direction = new_direction
		current_frames = 0
	else:
		current_frames += 1
	
	if current_frames >= frames_until_change:
		return new_direction
	else:
		return old_direction
		
	
	

