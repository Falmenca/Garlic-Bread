extends Node2D

var anim_node: AnimationPlayer 
var closest

func _ready() -> void:
	anim_node = $Sprite2D/AnimationPlayer
	closest = Global.find_closest_in_group(global_position, "enemies")
	if closest: 
		rotation = global_position.angle_to_point(closest.global_position)
	anim_node.play("attack")

func _physics_process(delta: float) -> void:
	anim_node.animation_finished.connect(func(anim_name): 
		if anim_name == "attack":
			queue_free()
	)
