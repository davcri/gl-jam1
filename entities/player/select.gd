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
	disable_items_collisions()
	var bodies = $Area2D.get_overlapping_bodies()
	for b in bodies:
		if b is Item:
			var item: Item = b
			grabbed_item = item
			item.change_state(item.STATES.GRABBED)


func release():
	enable_items_collisions()
	grabbed_item.change_state(grabbed_item.STATES.IDLE)
	grabbed_item = null


func disable_items_collisions():
	p.set_collision_mask_bit(1, false)


func enable_items_collisions():
	p.set_collision_mask_bit(1, true)
