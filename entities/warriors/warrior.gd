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
onready var bubble = $Bubble
onready var tween = $Tween

var wanted_item_type: String


func _ready() -> void:
	_change_texture(warrior_sprite_id)
	wanted_item_type = "sword"


func _change_texture(sprite_id):
	if sprite == null:
		return
	sprite.region_rect.position.x = 16 * sprite_id


func set_warrior_sprite_id(new_id):
	warrior_sprite_id = new_id
	_change_texture(warrior_sprite_id)
	

func show_wanted_item():
	bubble.show()


func get_wanted_item_type() -> String:
	return wanted_item_type


func _on_CheckItemArea_item_found(item: Item) -> void:
	if item.type == get_wanted_item_type():
		_on_wanted_item_found(item)
	else:
		print("Not my cup of tea")


func _on_wanted_item_found(item):
	bubble.close()
	item.disable_collisions()
	yield(get_tree().create_timer(0.5), "timeout")
	grab_item(item)
	yield(get_tree().create_timer(1.0), "timeout")
	go_away()
	
	
func grab_item(item):
	tween.interpolate_property(
		item,
		"position",
		item.position,
		$ItemGrabPosition.global_position,
		0.3, 
		Tween.TRANS_QUAD,
		Tween.EASE_OUT
	)
	tween.connect("tween_completed", self, "_on_item_grabbed", [item], CONNECT_ONESHOT)
	tween.start()


func _on_item_grabbed(a, b, item):
	Game.reparent_node(item, self)
	

func go_away():
	tween.interpolate_property(
		self,
		"position",
		position,
		Vector2(Game.size.x, position.y),
		3, 
		Tween.TRANS_LINEAR,
		Tween.TRANS_LINEAR
	)
	tween.start()
