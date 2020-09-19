extends KinematicBody2D

export(float, 100, 1000, 0.5) var speed = 100

var velocity = Vector2()

# state variables
var input_vec = Vector2()
var powerup = false


func _ready():
	pass


func _process(delta):
	input_vec = handle_input()
	velocity = calculate_velocity(input_vec)
	move_and_collide(velocity * delta)


func handle_input():
	input_vec = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		input_vec.x = 1
	elif Input.is_action_pressed("ui_left"):
		input_vec.x = -1
	if Input.is_action_pressed("ui_up"):
		input_vec.y = -1
	elif Input.is_action_pressed("ui_down"):
		input_vec.y = 1
	return input_vec


func calculate_velocity(input: Vector2):
	var vel = Vector2.ZERO
	vel = input.normalized() * speed
	return vel
