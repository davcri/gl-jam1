extends RayCast2D


onready var p = get_parent()


func _process(delta: float) -> void:
	cast_to = p.input_vec.normalized() * 16
	
