extends Area2D


signal item_exited(item)
signal item_entered(item)
signal item_available(item)


var item: Item = null


func _on_CheckItemArea_body_entered(body: Node) -> void:
	if body is Item:
		emit_signal("item_entered", body)
		item = body


func _on_CheckItemArea_body_exited(body: Node) -> void:
	if body is Item:
		emit_signal("item_exited", body)
		item = null


func _process(delta):
	if item == null:
		return
	if item.state == item.STATES.IDLE:
		emit_signal("item_available", item)
		item = null
