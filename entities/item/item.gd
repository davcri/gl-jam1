class_name Item
extends KinematicBody2D


class ItemData:
	var name: String
	var type: String
	var cost: int
	var texture_name
	
var data: ItemData


func _ready() -> void:
	load_item_data()
	
	
func load_item_data():
	data = ItemsDb.entries[0]
	for e in ItemsDb.entries:
		print(e.name)
	_load_texture(data.texture_name)


func _load_texture(texture_name):
	$Sprite.texture = ItemsDb.get_texture(texture_name)
	

func enable_collisions():
	$CollisionShape2D.set_deferred("disabled", false)
	

func disable_collisions():
	$CollisionShape2D.set_deferred("disabled", true)
