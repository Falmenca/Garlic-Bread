extends Node2D

var level
var distance = randf_range(400,1000) 
@onready var anim = $AnimationPlayer
var target
var angle
var land_pos: Vector2
var speed = 1
var exploding = false
var timer = 100.0

func _ready() -> void:
	#creates a annular sector towards the enemy where the potato lands
	$PoisonCloud.frame=5
	target = Global.find_closest_in_group(global_position, "enemies")
	if target: 
		angle = global_position.angle_to_point(target.global_position) + randf_range(-TAU/12, TAU/12)
	else:
		angle = randf_range(0,TAU)
	land_pos = global_position + Vector2(cos(angle), sin(angle)) * distance


func _physics_process(delta: float) -> void:
	if global_position.distance_to(land_pos) < 10 and not exploding:
		explode()
	$PoisonPotato.rotate(delta*3)
	var velocity = (land_pos - global_position).normalized()
	global_position += velocity * delta * speed * 300
	if timer<=0:
		queue_free()
	else:
		timer -= delta

func explode() -> void:
	exploding = true
	timer = 5.0
	anim.play("potato_explode")
	anim.animation_finished.connect(func(anim_name): if anim_name=="potato_explode": anim.play("new_animation"))
