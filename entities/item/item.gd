class_name Item
extends KinematicBody2D


class ItemData:
	var name: String
	var type: String
	var cost: int
	var texture_name

var data: ItemData

enum STATES {
	GRABBED,
	IDLE,
}

var state = STATES.GRABBED


func setup(p_data: ItemData):
	data = p_data
	_load_texture(p_data.texture_name)


func _load_texture(texture_name):
	$Sprite.texture = ItemsDb.get_texture(texture_name)


func change_state(new_state):
	state = new_state
	match state:
		STATES.IDLE:
			_start_idle_state()
		_:
			pass

func _start_idle_state():
	position.x = round((position.x + 8) / 16) * 16 - 8
	position.y = round((position.y + 8) / 16) * 16 - 8
