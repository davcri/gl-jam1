extends Area2D


signal item_found(item)

func _on_CheckItemArea_body_entered(body: Node) -> void:
	if body is Item:
		emit_signal("item_found", body)

