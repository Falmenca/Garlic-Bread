extends Node

var player : CharacterBody2D

func _ready() -> void:
	print(player)


func find_closest_in_group(position: Vector2, group_name: String) -> CharacterBody2D:
	##Returns closest node from set position from nodes in group of set group name
	var closest_dist = 0
	var closest: Node
	for node in get_tree().get_nodes_in_group(group_name):
		var dist = position.distance_to(node.position)
		if dist < closest_dist or not closest_dist:
			closest_dist = dist
			closest = node
	return closest
