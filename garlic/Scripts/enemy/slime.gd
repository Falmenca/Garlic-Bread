extends CharacterBody2D

@onready var RotationOffset: Node2D = $RotationOffset


@export var health = 50
@export var speed = 100
var PosAttack : Vector2
var RandDistX = 0
var RandDistY = 0
var ChaseDist = 400
var player 

func _ready():
	player = Global.player
	print(player)

func _physics_process(delta: float) -> void:
	
	if health < 1:
		_death()
	
	if player:
		_chase()


	move_and_slide()

func _death():
	pass
	#dies

func _chase(): # behavior to unstick enemies' balls from each other
	if position.distance_to(player.position)>ChaseDist:
		PosAttack= Vector2(player.position.x + RandDistX, player.position.y + RandDistY)
	else:
		PosAttack = player.position
	
	var direction = (PosAttack - global_position).normalized()
	velocity = direction * speed 
	RotationOffset.scale.x = sign(direction.x) #flips sprite/hitbox to direction

func _on_chase_timer_timeout() -> void:
	RandDistX = randf_range(-ChaseDist,ChaseDist)
	RandDistY = randf_range(-ChaseDist,ChaseDist)

	print(RandDistY, RandDistX)
