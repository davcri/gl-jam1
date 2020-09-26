extends Node

onready var item_scn = preload("res://entities/item/item.tscn")


func _ready() -> void:
	var i = 0
	for data in ItemsDb.entries:
		var item_node = item_scn.instance()
		item_node.setup(data)
		add_child(item_node)
		item_node.position.x = 60
		item_node.position.y = 80 + i * 16
		i += 1
