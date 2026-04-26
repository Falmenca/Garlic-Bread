extends CharacterBody2D

@onready var rotation_offset : Node2D = $RotationOffset

@export var health = 100
@export var speed = 400 

var direction : Vector2
var last_direction = 0
var acceleration = 5
var friction = 3

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
		last_direction = direction.x
	
	var lerpweight = delta * (acceleration if direction else friction)
	velocity = lerp(velocity, direction * speed, lerpweight)
	
	flip()
	
	knockback_physics(delta)
	
	move_and_slide()

func flip():
	if last_direction < 0:
		rotation_offset.scale.x = -1
	else: 
		rotation_offset.scale.x = 1
	
func take_damage(dmg):
	health = health - dmg #-dmg
	#print("a faggot just hit me")
	print("girl hp:", health)

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
