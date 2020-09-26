class_name Item
extends KinematicBody2D


class ItemData:
	var name: String
	var type: String
	var cost: int
	var texture_name
	
var data: ItemData


func setup(p_data: ItemData):
	data = p_data
	_load_texture(p_data.texture_name)

	
func _ready() -> void:
	pass
	
	
func _load_texture(texture_name):
	$Sprite.texture = ItemsDb.get_texture(texture_name)
	

func enable_collisions():
	$CollisionShape2D.set_deferred("disabled", false)
	

func disable_collisions():
	$CollisionShape2D.set_deferred("disabled", true)
