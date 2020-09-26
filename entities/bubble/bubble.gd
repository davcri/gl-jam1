class_name Bubble
extends Node2D

onready var anim := $AnimationPlayer
onready var icon_sprite := $Sprite/Icon

func set_object():
	pass


func close():
	anim.play("close")


func update_texture(texture_path: String):
	icon_sprite.texture = ItemsDb.get_texture(texture_path)

