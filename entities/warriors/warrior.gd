class_name Warrior
extends KinematicBody2D
tool

enum GFX_ID {
	WAR_1,
	WAR_2,
	WAR_3,
	WAR_4,
}

export(GFX_ID) var warrior_sprite_id = GFX_ID.WAR_1 setget set_warrior_sprite_id
onready var sprite = $Sprite


func _ready() -> void:
	_change_texture(warrior_sprite_id)


func _change_texture(sprite_id):
	if sprite == null:
		return
	sprite.region_rect.position.x = 16 * sprite_id


func set_warrior_sprite_id(new_id):
	warrior_sprite_id = new_id
	_change_texture(warrior_sprite_id)
	
	

func show_wanted_item(wanted_item):
	pass 


func get_wanted_item():
	return "an-item"
