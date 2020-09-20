extends Sprite


onready var p = get_parent()
onready var rc: RayCast2D = p.get_node("RayCast2D")

var grabbed_item: Item = null


func _process(delta: float) -> void:
	visible = (grabbed_item != null)
	if rc.cast_to != Vector2.ZERO:
		position.x = rc.cast_to.x
		position.y = rc.cast_to.y
	if grabbed_item:
		grabbed_item.position = global_position
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_select"):
		if grabbed_item:
			release()
		else:
			grab()


func grab():
	var bodies = $Area2D.get_overlapping_bodies()
	for b in bodies:
		if b is Item:
			var item: Item = b
			grabbed_item = item
			grabbed_item.disable_collisions()


func release():
	grabbed_item.enable_collisions()
	grabbed_item = null
