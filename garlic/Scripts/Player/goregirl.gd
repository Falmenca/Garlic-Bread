extends CharacterBody2D

@onready var rotation_offset : Node2D = $RotationOffset

@export var health = 100
@export var speed = 400 


var direction : Vector2
var last_direction : Vector2 = Vector2.ZERO
var acceleration = 5
var friction = 3

var dash_speed : float = 1.5
var dash_duration : float = 0.2
var dash_cooldown : float = 0.5
var dash_dur : float 
var dash_cd : float = 0
var dashing : bool = false

var knockback : Vector2 = Vector2.ZERO
var knockback_timer : float

func _ready():
	PlayerStats.reset_pStats()
	print(typeof(speed), speed)
	Global.player = self
	
	
func _physics_process(delta: float) -> void:
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	direction = direction.normalized() #no diagonal boost
	
	if direction.x != 0:
		last_direction.x = direction.x
	if direction.y != 0:
		last_direction.y = direction.y
	
	if Input.is_action_just_pressed("dash") and(not dashing) and dash_cd <= 0.0:
		dash_dur = dash_duration 
		dash_cd = dash_cooldown
	dash_cd -= delta
	
	var lerpweight = delta * (acceleration if direction else friction)
	velocity = lerp(velocity, direction * speed, lerpweight)
	
	#print (dash_cd, "cd")
	#print(dash_dur, "dur")
	flip()
	
	knockback_physics(delta)
	
	dash(delta)
	
	move_and_slide()

func flip():
	if last_direction.x < 0:
		rotation_offset.scale.x = -1
	else: 
		rotation_offset.scale.x = 1
	
func take_damage(dmg):
	health = health - dmg #-dmg
	#print("a faggot just hit me")
	print("girl hp:", health)
	DisplayNumbers.display_number(dmg, global_position, false)

func take_knockback(direction : Vector2,force : float, knockback_duration : float,):
	knockback = direction * force
	knockback_timer = knockback_duration

func knockback_physics(delta):
	if knockback_timer > 0:
		pass
		velocity = knockback
		knockback_timer -= delta
		if knockback_timer < 0:
			knockback = Vector2.ZERO

func dash(delta):
	if dash_dur < 0.0 :
		dashing = false
	else:
		dashing = true
		dash_dur -= delta
		velocity = last_direction * (speed * dash_speed)
