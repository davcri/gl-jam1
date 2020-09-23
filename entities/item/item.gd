class_name Item
extends KinematicBody2D


class ItemData:
	var name: String
	var type: String
	var cost: int
	var texture_name
	
var data: ItemData


func _ready() -> void:
	_init_data()


func _init_data():
	var file = File.new()
	file.open("res://data/items.csv", File.READ)
	var csv_data = file.get_csv_line()
	data = ItemData.new()
	data.name = csv_data[0]
	data.cost = csv_data[1]
	data.type = csv_data[2]
	data.texture_name = csv_data[3]
	_load_texture(data.texture_name)
	

func _load_texture(texture_name):
	$Sprite.texture = ItemsDb.get_texture(texture_name)
	

func enable_collisions():
	$CollisionShape2D.set_deferred("disabled", false)
	

func disable_collisions():
	$CollisionShape2D.set_deferred("disabled", true)
