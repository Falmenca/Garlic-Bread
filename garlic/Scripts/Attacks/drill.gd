extends Node2D

@onready var anim: AnimationPlayer = $AnimationPlayer

#Stats
@export var speed : int = 500
@export var duration : float = 5

var level
var steer  = 20
var closest
var target_angle

func _ready() -> void:
	global_position = Global.player.global_position
	z_index = Global.player.z_index-1
	closest = Global.find_closest_in_group(global_position, "enemies")
	
	if closest: 
		rotation = global_position.angle_to_point(closest.global_position)


func _physics_process(delta: float) -> void:
	if is_instance_valid(closest):
		target_angle = global_position.angle_to_point(closest.global_position)
		rotation = lerp_angle(rotation, target_angle, steer * delta)
	else:
		closest = Global.find_closest_in_group(global_position, "enemies")
	
	position += transform.x * speed * delta
	
	_expire(delta)

func _expire(delta):
	duration -= delta
	if duration < 0.0:
		anim.play("expire")
