extends Node2D


func pre_start(params):
	for key in params:
		var val = params[key]


func _ready() -> void:
	pass
	

func start():
	var war1 = $YSort/Warrior
	war1.show_wanted_item()
	

