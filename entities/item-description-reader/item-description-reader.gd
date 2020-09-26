extends Node2D

onready var dialogue = $Dialogue
onready var item_viewer = $ItemViewer


func _on_CheckItemArea_item_available(item):
	dialogue.hide()
	item_viewer.show()
	item_viewer.set_item_data(item)


func _on_CheckItemArea_item_exited(item) -> void:
	dialogue.show()
	item_viewer.hide()
