extends Area2D


func _on_CheckItemArea_body_entered(body: Node) -> void:
	if body is Item:
		print("Item entered ", body.name)

