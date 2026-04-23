extends Node2D

var anim_node: AnimationPlayer 
var closest

func _ready() -> void:
	anim_node = get_node("Sprite2D/AnimationPlayer")
	closest = find_closest_in_group(global_position, "enemies")
	if closest: 
		rotation = global_position.angle_to_point(closest.global_position)
	anim_node.play("attack")

func _physics_process(delta: float) -> void:
	anim_node.animation_finished.connect(func(anim_name): 
		if anim_name == "attack":
			queue_free()
	)

func find_closest_in_group(position: Vector2, name: String) -> CharacterBody2D:
	##Returns closest node from set position from nodes in group of set group name
	var closest_dist = 0
	var closest: Node
	for node in get_tree().get_nodes_in_group(name):
		var dist = position.distance_to(node.position)
		if dist < closest_dist or not closest_dist:
			closest_dist = dist
			closest = node
	return closest
