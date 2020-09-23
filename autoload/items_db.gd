extends Node

var entries = []


func _ready() -> void:
	var file = File.new()
	file.open("res://data/items.csv", File.READ)
	while !file.eof_reached():
		var line = file.get_csv_line()
		var item_data: Item.ItemData = Item.ItemData.new()
		item_data.name = line[0]
		item_data.cost = line[1]
		item_data.type = line[2]
		item_data.texture_name = line[3]
		entries.append(item_data)


func get_texture(texture_name):
	var texture_path = "res://assets/sprites/items/" + texture_name
	var new_texture = load(texture_path)
	if new_texture == null:
		print_debug("Failed loading texture ", texture_path)
		return null
	return new_texture
