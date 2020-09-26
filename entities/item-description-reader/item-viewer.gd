extends PanelContainer

onready var descriptions = $HBoxContainer/Descriptions
onready var values = $HBoxContainer/Values


func set_item_data(item: Item):
	var name_d = descriptions.get_node("Name")
	var type_d = descriptions.get_node("Type")
	var cost_d = descriptions.get_node("Cost")
	var name_v = values.get_node("Name")
	var type_v = values.get_node("Type")
	var cost_v = values.get_node("Cost")
	
	name_v.text = item.data.name
	type_v.text = item.data.type
	cost_v.text = str(item.data.cost)
