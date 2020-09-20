class_name Item
extends KinematicBody2D


func enable_collisions():
	$CollisionShape2D.set_deferred("disabled", false)
	

func disable_collisions():
	$CollisionShape2D.set_deferred("disabled", true)
