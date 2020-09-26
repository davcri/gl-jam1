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
	if Engine.is_editor_hint():
		return
	wanted_item_data = _calculate_wanted_item()
	bubble.update_texture(wanted_item_data.texture_name)


func _calculate_wanted_item():
	randomize()
	return ItemsDb.entries[randi() % len(ItemsDb.entries)] # TODO: implement this


func _change_texture(sprite_id):
	if sprite == null:
		return
	sprite.region_rect.position.x = 16 * sprite_id


func set_warrior_sprite_id(new_id):
	warrior_sprite_id = new_id
	_change_texture(warrior_sprite_id)


func show_wanted_item():
	bubble.show()


func _on_CheckItemArea_item_available(item):
	if item.state == item.STATES.GRABBED:
		return
	if is_item_good(item.data):
		_on_wanted_item_found(item)
	else:
		# TODO:
		print("Item not wanted")


func is_item_good(item_data: Item.ItemData):
	# TODO: add other logic. For now checks only item type
	if wanted_item_data.type == null:
		return false
	return wanted_item_data.name == item_data.name


func _on_wanted_item_found(item):
	grab_item(item)
	bubble.close()
	yield(get_tree().create_timer(1.0), "timeout")
	go_away()


func grab_item(item):
	item.change_state(item.STATES.GRABBED)
	tween.interpolate_property(
		item,
		"position",
		item.position,
		$ItemGrabPosition.global_position,
		0.2,
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
