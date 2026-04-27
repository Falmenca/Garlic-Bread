extends Node2D

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var hitbox : Area2D = $Hitbox
@onready var offset : Node2D = $Offset

#Stats
@export var speed : int = 500
@export var duration : float = 5
@export var size : float = 1
@export var damage : int = 8


var level =2
var steer  = 2
var closest
var target_angle

func stats_modifiers():
	pass

func _ready() -> void:
	#Stats
	hitbox.damage = damage
	scale = Vector2(size,size)
	
	#Find target
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
