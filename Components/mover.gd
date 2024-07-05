extends Node
class_name Mover

@onready var charge_timer = $ChargeTimer
@export var speed = 5.0
@export var charge_increment = 1
@export var max_charge = 20.0


signal charged_this_much(amount)
var body : CharacterBody2D
var held_direction: Vector2
var charge_amount = 0

func init(body: CharacterBody2D):
	self.body = body
	
func move(x, y):
	body.velocity = Vector2(x, y) * speed	
	
func start_charging(x, y):
	held_direction = Vector2(x, y)
	print("Held direction ", held_direction)
	charge_timer.start()

func release(delta):
	var horizontal = held_direction.x * charge_amount * delta
	var vertical = held_direction.y * charge_amount * delta
	move(horizontal, vertical)
	charge_timer.stop()
	
func calculate_charged_vector():
	return held_direction * speed * charge_amount

func _on_charge_timer_timeout():
	if charge_amount < max_charge:
		charge_amount += 1
		charged_this_much.emit(calculate_charged_vector())
