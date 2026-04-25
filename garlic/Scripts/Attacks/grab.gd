extends Node2D

var level
var target
var timer = 4
var dmg_timer = 4
var dmg_tick_length = 0.5
var damage = 1
var stored_speed
@onready var anim = $AnimationPlayer

func _ready() -> void:
	#looks for valid target if no enemies spawned disappear
	target = Global.find_closest_in_group(global_position, "enemies")
	if target:
		global_position = target.global_position
		stored_speed = target.speed
		target.speed = 0
		z_index = target.z_index+1
		anim.play("attack")
		anim.animation_finished.connect(func(anim_name):
			if anim_name == "attack":
				anim.play("loop"))
	else:
		queue_free()

func _physics_process(delta: float) -> void:
	#single target damage handling, no hitboxes
	if is_instance_valid(target):
		if timer > 0:
			if timer < dmg_timer:
				damage_enemy()
				dmg_timer -= dmg_tick_length
			timer -= delta
		else:
			target.speed = stored_speed
			queue_free()
	else:
		queue_free()
	

func damage_enemy() -> void:
	if target.health<damage:
		target._death()
		queue_free()
	else:
		target.take_damage(damage)
