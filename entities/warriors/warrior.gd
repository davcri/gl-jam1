class_name Warrior
extends KinematicBody2D
tool

signal warrior_went_away(warrior) # TODO: fix this. It does not take into account camera zoom
signal warrior_started_going_away(warrior)

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

var wanted_item_data: Item.ItemData


func _ready() -> void:
	_change_texture(warrior_sprite_id)
	wanted_item_data = _calculate_wanted_item()


func _calculate_wanted_item():
	var test = Item.ItemData.new()
	test.type = "sword"
	test.name = "Dark sword"
	return test


func _change_texture(sprite_id):
	if sprite == null:
		return
	sprite.region_rect.position.x = 16 * sprite_id


func set_warrior_sprite_id(new_id):
	warrior_sprite_id = new_id
	_change_texture(warrior_sprite_id)
	

func show_wanted_item():
	bubble.show()


func _on_CheckItemArea_item_found(item: Item) -> void:
	if item_is_good(item.data):
		_on_wanted_item_found(item)
	else:
		print("Item not wanted")
		
	
func item_is_good(item_data: Item.ItemData):
	# TODO: add other logic. For now checks only item type
	return wanted_item_data.type == item_data.type
	


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
	emit_signal("warrior_started_going_away", self)
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
	yield(tween, "tween_completed")
	emit_signal("warrior_went_away", self)
