extends Node2D

var distance = randf_range(200,400) 
var closest
var angle
var land_pos: Vector2
var speed = 200

func _ready() -> void:
	#creates a annular sector towards the enemy where the potato lands
	closest = Global.find_closest_in_group(global_position, "enemies")
	if closest: 
		angle = global_position.angle_to_point(closest.global_position) + randf_range(-TAU/12, TAU/12)
	else:
		angle = randf_range(0,TAU)
	land_pos = global_position + Vector2(cos(angle), sin(angle)) * distance


func _physics_process(delta: float) -> void:
	var velocity = (land_pos - global_position).normalized()
	$Sprite2D.rotate(delta*3)
	if global_position.distance_to(land_pos) < 10:
		explode()
	position = velocity * delta * speed

func explode() -> void:
	queue_free()
