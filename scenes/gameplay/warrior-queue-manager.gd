extends Node

onready var tween := $Tween
onready var warrior_buying_pos := get_parent().get_node("WarriorBuyingPosition")

var war_queue = []


func _ready() -> void:
	war_queue = get_tree().get_nodes_in_group("warriors")
	for w in war_queue:
		_connect_war_signal(w)

	var first_war = war_queue.pop_front()
	first_war.position = warrior_buying_pos.position


func _connect_war_signal(war: Warrior):
	war.connect("warrior_started_going_away", self, "_on_warrior_started_going_away")


func _on_warrior_started_going_away(war: Warrior):
	yield(get_tree().create_timer(0.5), "timeout")
	move_warrior_to_pos(war_queue.pop_front(), warrior_buying_pos.position)


func move_warrior_to_pos(war, target_pos: Vector2):
	var distance = war.position.distance_to(target_pos)
	var speed = 50
	var duration = distance / speed

	tween.interpolate_property(
		war,
		"position",
		war.position, # from
		target_pos, # to
		duration,
		Tween.TRANS_LINEAR,
		Tween.TRANS_LINEAR
	)
	tween.start()
	yield(tween, "tween_completed")
	war.show_wanted_item()
