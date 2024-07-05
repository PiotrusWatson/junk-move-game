extends CharacterBody2D

@onready var mover = $Mover

var last_horizontal = 0
var last_vertical = 0

var horizontal_axis: Axis
var vertical_axis: Axis

func _ready():
	mover.init(self)
	horizontal_axis = Axis.new(10)
	vertical_axis = Axis.new(10)

func axes_changed(h, v):
	return h != last_horizontal or v != last_vertical
	
func axes_released(h, v):
	return h == 0 and v == 0
func _process(delta):
	var horizontal = Input.get_axis("Left", "Right")
	var vertical = Input.get_axis("Up", "Down")
	
	horizontal = horizontal_axis.get_input(horizontal)
	vertical = vertical_axis.get_input(vertical)
	
	if axes_released(horizontal, vertical):
		mover.release(delta)
	elif axes_changed(horizontal, vertical):
		mover.start_charging(horizontal, vertical)
	
	last_horizontal = horizontal
	last_vertical = vertical
	
	move_and_slide()
	
