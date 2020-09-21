class_name Bubble
extends Node2D

onready var anim := $AnimationPlayer


func set_object():
	pass


func close():
	anim.play("close")
