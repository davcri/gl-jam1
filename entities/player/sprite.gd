extends Sprite

onready var p = get_parent()
onready var ap = $AnimationPlayer


func _process(delta):
	var dir = p.input_vec
	if dir == Vector2.ZERO:
		ap.stop()
	if dir.x > 0:
		return ap.play("walk_right")
	elif dir.x < 0:
		return ap.play("walk_left")
	if dir.y > 0:
		return ap.play("walk_down")
	elif dir.y < 0:
		return ap.play("walk_up")
		
