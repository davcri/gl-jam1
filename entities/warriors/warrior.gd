class_name Warrior
extends KinematicBody2D


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_1):
		position.x -= 1
	if Input.is_key_pressed(KEY_2):
		position.x += 1
		

func show_wanted_item(wanted_item):
	pass 


func get_wanted_item():
	return "an-item"
