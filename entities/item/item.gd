class_name Item
extends KinematicBody2D


class ItemData:
	var name: String
	var type: String
	var cost: int
	
	func ciao():
		print("Hello")
	

var data: ItemData


func _ready() -> void:
	_init_data()


func _init_data():
	data = ItemData.new()
	data.cost = 100
	data.type = "sword"
	data.name = "Simple Sword"
	

func enable_collisions():
	$CollisionShape2D.set_deferred("disabled", false)
	

func disable_collisions():
	$CollisionShape2D.set_deferred("disabled", true)
