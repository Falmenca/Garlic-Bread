extends Node2D

var level
var anim_node: AnimationPlayer 
var closest

func _ready() -> void:
	z_index = Global.player.z_index-1
	anim_node = $Sprite2D/AnimationPlayer
	closest = Global.find_closest_in_group(global_position, "enemies")
	if closest: 
		rotation = global_position.angle_to_point(closest.global_position)
	anim_node.play("attack")

func _physics_process(delta: float) -> void:
	position = Global.player.position
	anim_node.animation_finished.connect(func(anim_name): 
		if anim_name == "attack":
			queue_free()
	)
