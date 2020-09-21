extends Node

var size := Vector2.ZERO


func _ready() -> void:
	get_tree().connect("screen_resized", self, "_	on_screen_resized")
	register_size()


func _on_screen_resized():
	register_size()
	
	
func register_size():
	size = get_viewport().get_visible_rect().size


func set_main_node(node: Main):
	Scenes.main = node


func change_scene(new_scene, params= {}):
	Scenes._change_scene(new_scene, params)
	
	
func reparent_node(node: Node2D, new_parent, update_transform = true):
	var previous_xform = node.global_transform
	node.get_parent().remove_child(node)
	new_parent.add_child(node)
	node.global_transform = previous_xform
