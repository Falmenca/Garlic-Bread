extends CharacterBody2D

@export var speed = 400 
var direction : Vector2
var acceleration = 5
var friction = 3

func _ready():
	print(typeof(speed), speed)
	Global.player = self
	
func _physics_process(delta: float) -> void:
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	direction = direction.normalized() #no diagonal boost

	var lerpweight = delta * (acceleration if direction else friction)
	velocity = lerp(velocity, direction * speed, lerpweight)


	move_and_slide()
