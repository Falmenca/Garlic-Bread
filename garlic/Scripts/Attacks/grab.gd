extends Node2D

var closest
var timer = 1.0
var stored_speed

func _ready() -> void:
	closest = Global.find_closest_in_group(global_position, "enemies")
	if closest:
		global_position = closest.global_position
		stored_speed = closest.speed
		closest.speed = 0
		z_index = closest.z_index+1
	else:
		queue_free()

func _physics_process(delta: float) -> void:
	if closest:
		global_position = closest.global_position
		if timer > 0:
			timer-=delta
		else:
			closest.speed = stored_speed
			queue_free()
	else:
		queue_free()
