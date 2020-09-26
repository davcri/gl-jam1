extends Area2D


signal item_found(item) # TODO: refactor into "item_entered"
signal item_exited(item)

var item = null

func _on_CheckItemArea_body_entered(body: Node) -> void:
	if body is Item:
		emit_signal("item_found", body)
		item = body


func _on_CheckItemArea_body_exited(body: Node) -> void:
	if body is Item:
		emit_signal("item_exited", body)
		item = null
